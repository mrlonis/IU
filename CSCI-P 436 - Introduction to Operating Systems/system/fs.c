/**
 * fs.c
 *
 * Part of: Assignment 6
 *
 * Created By: Martin Swaney
 * Created On: ?
 * Last Modified By: Matthew Lonis
 * Last Modified On: 26 April 2018
 */

#include <xinu.h>
#include <kernel.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>

#ifdef FS
#include <fs.h>

static struct fsystem fsd;
int dev0_numblocks;
int dev0_blocksize;
char *dev0_blocks;

extern int dev0;

char block_cache[512];

#define SB_BLK 0
#define BM_BLK 1
#define RT_BLK 2

#define NUM_FD 16
struct filetable oft[NUM_FD];
int next_open_fd = 0;

#define INODES_PER_BLOCK (fsd.blocksz / sizeof(struct inode))
#define NUM_INODE_BLOCKS (((fsd.ninodes % INODES_PER_BLOCK) == 0) ? fsd.ninodes / INODES_PER_BLOCK : (fsd.ninodes / INODES_PER_BLOCK) + 1)
#define FIRST_INODE_BLOCK 2

int inode_id = 1;

int fs_fileblock_to_diskblock(int dev, int fd, int fileblock);

/* YOUR CODE GOES HERE */

int fs_fileblock_to_diskblock(int dev, int fd, int fileblock) {
    int diskblock;
    
    if (fileblock >= INODEBLOCKS - 2) {
        printf("No indirect block support\n");
        return SYSERR;
    }
    
    diskblock = oft[fd].in.blocks[fileblock]; //get the logical block address
    
    return diskblock;
}

/* read in an inode and fill in the pointer */
int fs_get_inode_by_num(int dev, int inode_number, struct inode *in) {
    int bl, inn;
    int inode_off;
    
    if (dev != 0) {
        printf("Unsupported device\n");
        return SYSERR;
    }
    
    if (inode_number > fsd.ninodes) {
        printf("fs_get_inode_by_num: inode %d out of range\n", inode_number);
        return SYSERR;
    }
    
    bl = inode_number / INODES_PER_BLOCK;
    inn = inode_number % INODES_PER_BLOCK;
    bl += FIRST_INODE_BLOCK;
    
    inode_off = inn * sizeof(struct inode);
    
    /*
     * printf("in_no: %d = %d/%d\n", inode_number, bl, inn);
     * printf("inn*sizeof(struct inode): %d\n", inode_off);
     */
    
    bs_bread(dev0, bl, 0, &block_cache[0], fsd.blocksz);
    memcpy(in, &block_cache[inode_off], sizeof(struct inode));
    
    return OK;
}

int fs_put_inode_by_num(int dev, int inode_number, struct inode *in) {
    int bl, inn;
    
    if (dev != 0) {
        printf("Unsupported device\n");
        return SYSERR;
    }
    
    if (inode_number > fsd.ninodes) {
        printf("fs_put_inode_by_num: inode %d out of range\n", inode_number);
        return SYSERR;
    }
    
    bl = inode_number / INODES_PER_BLOCK;
    inn = inode_number % INODES_PER_BLOCK;
    bl += FIRST_INODE_BLOCK;
    
    /*
     * bprintf("in_no: %d = %d/%d\n", inode_number, bl, inn);
     */
    
    bs_bread(dev0, bl, 0, block_cache, fsd.blocksz);
    memcpy(&block_cache[(inn * sizeof(struct inode))], in, sizeof(struct inode));
    bs_bwrite(dev0, bl, 0, block_cache, fsd.blocksz);
    
    return OK;
}

int fs_mkfs(int dev, int num_inodes) {
    int i;
    
    if (dev == 0) {
        fsd.nblocks = dev0_numblocks;
        fsd.blocksz = dev0_blocksize;
    } else {
        printf("Unsupported device\n");
        return SYSERR;
    }
    
    if (num_inodes < 1) {
        fsd.ninodes = DEFAULT_NUM_INODES;
    } else {
        fsd.ninodes = num_inodes;
    }
    
    i = fsd.nblocks;
    while ((i % 8) != 0) {
        i++;
    }
    
    fsd.freemaskbytes = i / 8;
    
    if ((fsd.freemask = getmem(fsd.freemaskbytes)) == (void *)SYSERR) {
        printf("fs_mkfs memget failed.\n");
        return SYSERR;
    }
    
    /* zero the free mask */
    for (i = 0; i < fsd.freemaskbytes; i++) {
        fsd.freemask[i] = '\0';
    }
    
    fsd.inodes_used = 0;
    
    /* write the fsystem block to SB_BLK, mark block used */
    fs_setmaskbit(SB_BLK);
    bs_bwrite(dev0, SB_BLK, 0, &fsd, sizeof(struct fsystem));
    
    /* write the free block bitmask in BM_BLK, mark block used */
    fs_setmaskbit(BM_BLK);
    bs_bwrite(dev0, BM_BLK, 0, fsd.freemask, fsd.freemaskbytes);
    
    return 1;
}

void fs_print_fsd(void) {
    printf("fsd.ninodes: %d\n", fsd.ninodes);
    printf("sizeof(struct inode): %d\n", sizeof(struct inode));
    printf("INODES_PER_BLOCK: %d\n", INODES_PER_BLOCK);
    printf("NUM_INODE_BLOCKS: %d\n", NUM_INODE_BLOCKS);
}

/* specify the block number to be set in the mask */
int fs_setmaskbit(int b) {
    int mbyte, mbit;
    mbyte = b / 8;
    mbit = b % 8;
    
    fsd.freemask[mbyte] |= (0x80 >> mbit);
    return OK;
}

/* specify the block number to be read in the mask */
int fs_getmaskbit(int b) {
    int mbyte, mbit;
    mbyte = b / 8;
    mbit = b % 8;
    
    return (((fsd.freemask[mbyte] << mbit) & 0x80) >> 7);
    return OK;
}

/* specify the block number to be unset in the mask */
int fs_clearmaskbit(int b) {
    int mbyte, mbit, invb;
    mbyte = b / 8;
    mbit = b % 8;
    
    invb = ~(0x80 >> mbit);
    invb &= 0xFF;
    
    fsd.freemask[mbyte] &= invb;
    return OK;
}

/* This is maybe a little overcomplicated since the lowest-numbered
 block is indicated in the high-order bit.  Shift the byte by j
 positions to make the match in bit7 (the 8th bit) and then shift
 that value 7 times to the low-order bit to print.  Yes, it could be
 the other way...  */
void fs_printfreemask(void) {
    int i, j;
    
    for (i = 0; i < fsd.freemaskbytes; i++) {
        for (j = 0; j < 8; j++) {
            printf("%d", ((fsd.freemask[i] << j) & 0x80) >> 7);
        }
        
        if ((i % 8) == 7) {
            printf("\n");
        }
    }
    printf("\n");
}

int fs_open(char *filename, int flags) {
    if (filename == NULL || filename[0] == NULLCH) {
        fprintf(stderr, "fs_open(): File name is NULL or only the NULL Character.\n");
        return SYSERR;
    }
    
    if (next_open_fd == DIRECTORY_SIZE){
        fprintf(stderr, "fs_open(): No file can be open right now. next_open_fd == DIRECTORY_SIZE.\n");
        return SYSERR;
    }
    
    int i = 0, inode_number;
    
    while (i < DIRECTORY_SIZE) {
        if (strncmp(fsd.root_dir.entry[i].name, filename, FILENAMELEN) == 0) {
            inode_number = fsd.root_dir.entry[i].inode_num;
            
            if (inode_number == -1) {
                fprintf(stderr, "fs_open(): File %s does not exist.\n", filename);
                return SYSERR;
            }
            
            struct inode new_inode;
            fs_get_inode_by_num(dev0, inode_number, &new_inode);
            
            oft[next_open_fd].state = FSTATE_OPEN;
            oft[next_open_fd].fileptr = 0;
            oft[next_open_fd].de = &(fsd.root_dir.entry[i]);
            
            oft[next_open_fd].in = new_inode;
            
            oft[next_open_fd].in.nlink++;
            
            if (flags == 1) {
                oft[next_open_fd].fileptr = oft[next_open_fd].in.size;
            }
            
            fs_put_inode_by_num(dev0, inode_number, &oft[next_open_fd].in);
            
            next_open_fd++;
            return next_open_fd - 1;
        }
        
        i++;
    }
    
    fprintf(stderr, "fs_open(): File %s does not exist\n", filename);
    return SYSERR;
}

int fs_close(int fd) {
    if (fd > next_open_fd || fd < 0) {
        fprintf(stderr, "fs_close: Not a valid fd.\n");
        return SYSERR;
    }
    
    if (oft[fd].state == -1) {
        fprintf(stderr, "fs_close: Bad fd. oft[fd].state == -1.\n");
        return SYSERR;
    }
    
    
    struct inode inode_to_update;
    fs_get_inode_by_num(dev0, oft[fd].in.id, &inode_to_update);
    inode_to_update.nlink--;
    fs_put_inode_by_num(dev0, oft[fd].in.id, &inode_to_update);
    
    oft[fd].state = FSTATE_CLOSED;
    oft[fd].fileptr = 0;
    
    return OK;
}

int fs_create(char *filename, int mode) {
    if (mode == O_CREAT) {
        int i;
        for (i = 0; i < DIRECTORY_SIZE; i++) {
            if (!strncmp(filename, fsd.root_dir.entry[i].name, FILENAMELEN)) {
                fprintf(stderr, "fs_create(): File %s already exists\n", filename);
                return SYSERR;
            }
        }
        
        int fd = next_open_fd++;
        struct filetable ft;
        ft.state = FSTATE_OPEN;
        ft.fileptr = 0;
        ft.de = &(fsd.root_dir.entry[fsd.root_dir.numentries++]);
        
        strcpy((ft.de)->name, filename);
        
        struct inode in;
        in.id = inode_id++;
        in.type = INODE_TYPE_FILE;
        
        fs_put_inode_by_num(dev0, in.id, &in);
        
        int block = in.id / INODES_PER_BLOCK;
        block += FIRST_INODE_BLOCK;
        fs_setmaskbit(block);
        
        memcpy(&(ft.in), &in, sizeof(struct inode));
        
        memcpy(&(ft.de->inode_num), &(in.id), sizeof(int));
        memcpy(&(fsd.root_dir.entry[fsd.root_dir.numentries-1].inode_num), &(in.id), sizeof(int));
        
        memcpy(&oft[fd], &ft, sizeof(struct filetable));
        
        fsd.inodes_used++;
        
        return fd;
    }
    
    fprintf(stderr, "fs_create(): Mode is not O_CREAT.\n");
    return SYSERR;
}

int fs_seek(int fd, int offset) {
    int fileptr = oft[fd].fileptr + offset;
    
    if(fileptr > oft[fd].in.size) {
        printf("fs_seek(): fileptr exceeds the file size.\n");
        return SYSERR;
    }
    
    if((fileptr/fsd.blocksz) > INODEBLOCKS) {
        printf("fs_seek(): fileptr is out of boundary.\n");
        return SYSERR;
    } else {
        oft[fd].fileptr = fileptr;
    }
    
    if (fileptr < 0) {
        fprintf(stderr, "fs_seek(): fileptr exceeds file boundary. resetting pointer to beginning of file.\n");
        fileptr = 0;
    }
    
    memcpy(&(oft[fd].fileptr), &fileptr, sizeof(int));
    return fd;
}

int fs_read(int fd, void *buf, int nbytes) {
    int original_number_of_bytes = nbytes;
    
    if (oft[fd].state == FSTATE_CLOSED) {
        fprintf(stderr, "fs_read(): File is closed.\n");
        return 0;
    }
    
    int inode_block = (oft[fd].fileptr / fsd.blocksz);
    int inode_offset = (oft[fd].fileptr % fsd.blocksz);
    
    if (inode_block < INODEBLOCKS) {
        int dst_block = oft[fd].in.blocks[inode_block];
        
        while (nbytes > 0) {
            if (nbytes < (fsd.blocksz - inode_offset)) {
                bs_bread(dev0, dst_block, inode_offset, buf, nbytes);
                
                oft[fd].fileptr += nbytes;
                buf += nbytes;
                nbytes = 0;
                return original_number_of_bytes;
            } else {
                if (inode_block == INODEBLOCKS - 1) {
                    fprintf(stderr, "fs_read(): requested bytes exceeds limit, wrote valid values only.\n");
                    return original_number_of_bytes - nbytes;
                }
                
                bs_bread(dev0, dst_block, inode_offset, buf, fsd.blocksz - inode_offset);
                
                buf += (fsd.blocksz - inode_offset);
                nbytes -= (fsd.blocksz - inode_offset);
                oft[fd].fileptr += (fsd.blocksz - inode_offset);
                
                dst_block = oft[fd].in.blocks[++inode_block];
                inode_offset = 0;
            }
        }
    }
    return original_number_of_bytes - nbytes;
}

int fs_write(int fd, void *buf, int nbytes) {
    int original_number_of_bytes = nbytes;
    int inode_offset = (oft[fd].fileptr % fsd.blocksz);
    int inode_block = (oft[fd].fileptr / fsd.blocksz);
    int i;
    
    if (oft[fd].state == FSTATE_CLOSED) {
        fprintf(stderr, "fs_write(): invalid descriptor.\n");
        return 0;
    } else if (inode_block < INODEBLOCKS) {
        while (nbytes > 0) {
            if (oft[fd].in.blocks[inode_block] == 0) {
                
                i = 0;
                for (i = 0; i < fsd.nblocks; i++) {
                    if (fs_getmaskbit(i) == 0) {
                        break;
                    }
                }
                
                memcpy(oft[fd].in.blocks + inode_block, &i, sizeof(int));
                oft[fd].in = oft[fd].in;
                fs_put_inode_by_num(dev0, oft[fd].in.id, &oft[fd].in);
                fs_setmaskbit(i);
            } else if (oft[fd].in.blocks[inode_block] > 0) {
                i = oft[fd].in.blocks[inode_block];
            }
            
            if (nbytes < (fsd.blocksz - inode_offset)) {
                bs_bwrite(dev0, i, inode_offset, buf, nbytes);
                oft[fd].fileptr += nbytes;
                nbytes = 0;
                return original_number_of_bytes;
            } else {
                if (inode_block == INODEBLOCKS - 1) {
                    fprintf(stderr, "fs_write(): requested bytes exceeds limit, wrote valid values only.\n");
                    return original_number_of_bytes - nbytes;
                }
                
                bs_bwrite(dev0, i, inode_offset, buf, fsd.blocksz - inode_offset);
                buf += (fsd.blocksz - inode_offset);
                nbytes -= (fsd.blocksz - inode_offset);
                oft[fd].fileptr += (fsd.blocksz - inode_offset);
                inode_block++;
                inode_offset = 0;
            }
        }
    }
    
    return original_number_of_bytes - nbytes;
}

#endif /* FS */
