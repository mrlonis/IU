/**
 * creditc.c
 *
 * Description: Shows credits, uses sd card, and plays audio
 *
 * Created On: 8 December 2017
 * Created By: Matthew Lonis & Alvaro Michael
 * Last Modified On: 8 December 2017
 * Last Modified By: Matthew Lonis
 */

#include <stm32f30x.h>  // Pull in include files for F30x standard drivers
#include <f3d_delay.h>
#include <f3d_init.h>
#include <f3d_lcd_sd.h>
#include <f3d_nunchuk.h>
#include <f3d_rtc.h>
#include <f3d_systick.h>
#include <f3d_timer2.h>
#include <f3d_dac.h>
#include <glcdfont.h>
#include <diskio.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <ff.h>

#define AUDIOBUFSIZE 128
#define RIFF 'FFIR'
#define WAVE 'EVAW'
#define fmt ' tmf'
#define data 'atad'
#define gridCellSize 15

/*
 * SD Functions
 */
void sd_die();
void sd_openFile(char string[]);
void sd_typeFileContents();
void sd_closeFile();
void sd_openRootDir();
void sd_directoryListing();
void sd_drawBMP(char * string, uint8_t towerOrEnemy, uint8_t xCoord, uint16_t yCoord);

void playAudio();

extern uint8_t Audiobuf[AUDIOBUFSIZE];
extern int audioplayerHalf;
extern int audioplayerWhole;

struct bmpfile_magic {
    unsigned char magic[2];
};

struct bmpfile_header {
    uint32_t filesz;
    uint16_t creator1;
    uint16_t creator2;
    uint32_t bmp_offset;
};

typedef struct {
    uint32_t header_sz;
    int32_t width;
    int32_t height;
    uint16_t nplanes;
    uint16_t bitspp;
    uint32_t compress_type;
    uint32_t bmp_bytesz;
    int32_t hres;
    int32_t vres;
    uint32_t ncolors;
    uint32_t nimpcolors;
} BITMAPINFOHEADER;

struct bmppixel { // little endian byte order
    uint8_t b;
    uint8_t g;
    uint8_t r;
};

struct ckhd {
    uint32_t ckID;
    uint32_t cksize;
};

struct fmtck {
    uint16_t wFormatTag;
    uint16_t nChannels;
    uint32_t nSamplesPerSec;
    uint32_t nAvgBytesPerSec;
    uint16_t nBlockAlign;
    uint16_t wBitsPerSample;
};

FATFS Fatfs;        // File system object
FIL Fil;        // File object
FIL fid;        /* File object */
BYTE Buff[ST7735_width];        // File read buffer
int ret;

FRESULT rc;        // Result code
DIR dir;        // Directory object
FILINFO fno;        // File information object
UINT bw, br;
unsigned int retval;

struct bmpfile_magic magic;
struct bmpfile_header header;
BITMAPINFOHEADER info;
struct bmppixel pixel;

int bytesread;
struct ckhd hd;
uint32_t  waveid;
struct fmtck fck;
TCHAR var;
struct ckhd hd;
uint32_t  waveid;
struct fmtck fck;

nunchuk_t nunData;
uint16_t colors[128];
uint8_t i;

uint8_t credits() {
    f_mount(0, &Fatfs);        /* Register volume work area (never fails) */
    uint8_t selection = 0;
    uint8_t redraw = 1;
    
    f3d_lcd_fillScreen(BLACK);
    f3d_lcd_drawString(21, 1, "C335 Defense", WHITE, BLACK);
    f3d_lcd_drawString(0, 10, "This game is brought to you by Matthew Lonis & Alvaro Michael. This is a tower defense game inspired by Bloons Tower Defense 5. Thanks for Playing!", WHITE, BLACK);
    
    while (1) {
        f3d_nunchuk_read(&nunData);

	if (nunData.z == 1) {
	  return 1;
        }
        
        playAudio();
    }
}

void sd_die() {
    printf("Failed with rc=%u.\n", rc);
    while (1);
}

void sd_openFile(char string[]) {
    printf("\nOpen an existing file (%s).\n", string);
    rc = f_open(&Fil, string, FA_READ);
    
    if (rc) {
        sd_die(rc);
    }
}

void sd_typeFileContents() {
    printf("\nType the file content.\n");
    for (;;) {
        rc = f_read(&Fil, Buff, sizeof Buff, &br);    /* Read a chunk of file */
        if (rc || !br) break;                    /* Error or end of file */
        int i;
        for (i = 0; i < br; i++)                /* Type the data */
            putchar(Buff[i]);
    }
    if (rc) sd_die(rc);
}

void sd_closeFile() {
    printf("\nClose the file.\n");
    rc = f_close(&Fil);
    if (rc) {
        sd_die(rc);
    }
}

void sd_openRootDir() {
    printf("\nOpen root directory.\n");
    rc = f_opendir(&dir, "");
    if (rc) sd_die(rc);
}

void sd_directoryListing() {
    printf("\nDirectory listing...\n");
    for (;;) {
        rc = f_readdir(&dir, &fno);        /* Read a directory item */
        if (rc || !fno.fname[0]) break;    /* Error or end of dir */
        if (fno.fattrib & AM_DIR) {
            printf("   <dir>  %s\n", fno.fname);
        } else {
            printf("%8lu  %s\n", fno.fsize, fno.fname);
        }
    }
    if (rc) sd_die(rc);
}

void sd_drawBMP(char * string, uint8_t towerOrEnemy, uint8_t xCoord, uint16_t yCoord) {
    uint8_t i, x, y;
    sd_openFile(string);
    
    rc = f_read(&Fil, (void *) &magic, 2, &br);
    printf ("Magic %c%c\n", magic.magic[0], magic.magic[1]);
    
    rc = f_read(&Fil, (void *) &header , sizeof (header), &br);
    printf ("file size %d offset %d\n", header.filesz, header.bmp_offset);
    
    rc = f_read(&Fil, (void *) &info , sizeof (info), &br);
    printf ("Width %d Height %d, bitspp %d\n", info.width, info.height, info.bitspp);
    
    Fil.fptr = header.bmp_offset;
    
    if (towerOrEnemy == 0) {
        f3d_lcd_setAddrWindow((xCoord * 16), (yCoord * 16) + 9, (gridCellSize - 1) + (xCoord * 16), (gridCellSize - 1) + 9 + (yCoord * 16), MADCTLGRAPHICS);
    } else if (towerOrEnemy == 1) {
        f3d_lcd_setAddrWindow(xCoord, yCoord, (gridCellSize - 1) + xCoord, (gridCellSize - 1) + yCoord, MADCTLGRAPHICS);
    }
    
    for (y = 0; y < gridCellSize; y++) {
        for (x = 0; x < gridCellSize; x++) {
            rc = f_read(&Fil, (void *) &pixel, sizeof (pixel), &br);
            colors[x] = ((pixel.b >> 3) << 11) | ((pixel.g >> 2) << 5) | (pixel.r >> 3);
        }
        
        f3d_lcd_pushColor(colors, gridCellSize);
    }
    
    sd_closeFile();
}

/*
 * Audio Functions
 */
void readckhd(FIL *Fil, struct ckhd *hd, uint32_t ckID) {
    f_read(Fil, hd, sizeof(struct ckhd), &ret);
    
    if (ret != sizeof(struct ckhd)) {
        exit(-1);
    }
    
    if (ckID && (ckID != hd->ckID)) {
        exit(-1);
    }
}

void playAudio() {
    sd_openFile("thermo.wav");
    
    if (!rc) {
        readckhd(&Fil, &hd, 'FFIR');
        
        f_read(&Fil, &waveid, sizeof(waveid), &ret);
        if ((ret != sizeof(waveid)) || (waveid != 'EVAW'))
            return;
        
        readckhd(&Fil, &hd, ' tmf');
        
        f_read(&Fil, &fck, sizeof(fck), &ret);
        
        // skip over extra info
        
        if (hd.cksize != 16) {
            //printf("extra header info %d\n", hd.cksize - 16);
            f_lseek(&Fil, hd.cksize - 16);
        }
        
        /*
         printf("audio format 0x%x\n", fck.wFormatTag);
         printf("channels %d\n", fck.nChannels);
         printf("sample rate %d\n", fck.nSamplesPerSec);
         printf("data rate %d\n", fck.nAvgBytesPerSec);
         printf("block alignment %d\n", fck.nBlockAlign);
         printf("bits per sample %d\n", fck.wBitsPerSample);
         */
        
        // now skip all non-data chunks !
        
        while(1){
            readckhd(&Fil, &hd, 0);
            if (hd.ckID == 'atad')
                break;
            f_lseek(&Fil, hd.cksize);
        }
        
        printf("Samples %d\n", hd.cksize);
        
        // Play it !
        
        //      audioplayerInit(fck.nSamplesPerSec);
        
        f_read(&Fil, Audiobuf, AUDIOBUFSIZE, &ret);
        hd.cksize -= ret;
        
        audioplayerStart();
        
        while (hd.cksize) {
            
            int next = hd.cksize > AUDIOBUFSIZE/2 ? AUDIOBUFSIZE/2 : hd.cksize;
            
            if (audioplayerHalf) {
                if (next < AUDIOBUFSIZE/2)
                    bzero(Audiobuf, AUDIOBUFSIZE/2);
                f_read(&Fil, Audiobuf, next, &ret);
                hd.cksize -= ret;
                audioplayerHalf = 0;
            }
            
            if (audioplayerWhole) {
                if (next < AUDIOBUFSIZE/2)
                    bzero(&Audiobuf[AUDIOBUFSIZE/2], AUDIOBUFSIZE/2);
                f_read(&Fil, &Audiobuf[AUDIOBUFSIZE/2], next, &ret);
                hd.cksize -= ret;
                audioplayerWhole = 0;
            }
        }
        
        audioplayerStop();
    }
    
    sd_closeFile();
}
