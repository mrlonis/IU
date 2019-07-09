/**
 * Filename: hw3.c
 *
 * Description:
 *
 * Created By: Matthew Lonis
 * Created On: 13 October 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: 23 October 2017
 *
 * Part Of: Homework 3
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * macros
 */

/*
 * These are used to find out the format bits
 */
#define typesOne(x) (((x) >> 13) & 0x7) // Leftmost 3 bits
#define typesTwo(x) (((x) >> 11) & 0x3)
#define typesThree(x) (((x) >> 10) & 0x1)
#define types(x) (((x) >> 10) & 0x1f) // Leftmost 6 bits

/*
 * Immediates
 */
#define imm3(x) (((x) >> 6) & 0x7)
#define imm5(x) (((x) >> 6) & 0x1f)
#define imm8(x) (x & 0xff)

/*
 * Shift by immediate, move register (row 1)
 */
#define row1Rd(x) (x & 0x7)
#define row1Rm(x) (((x) >> 3) & 0x7)
#define row1Opcode(x) (((x) >> 11) & 0x3)

/*
 * add/subtract register & add/subtract immediate (row 2 & 3)
 */
#define row2_3Opc(x) (((x) >> 9) & 0x1)
#define row2_3Rd(x) (x & 0x7)
#define row2_3Rn(x) (((x) >> 3) & 0x7)
#define row2_3Rm(x) (((x) >> 6) & 0x7)

/*
 * Add.Subtract/Move immediate (row 4)
 */
#define row4Opcode(x) (((x) >> 11) & 0x3)
#define row4Rdn(x) (((x) >> 8) & 0x7)

/*
 * Data-processing regist (row 5)
 */
#define row5Opcode(x) (((x) >> 6) & 0xf)
#define row5Rdn(x) (x & 0x7)
#define row5Rm(x) (((x) >> 3) & 0x7)

/*
 * register names as seen in W05-01 Slides
 *
 * Low Registers: 0 - 7
 * High Registers 8 - 12
 */
char *regnames[] = {"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "sp", "lr", "pc", "xPSR"};

/*
 * Opcode names
 */
char *row1Opnames[] = {"lsls", "lsrs", "asrs", "movs"};

char *row4Opnames[] = {"movs", "cmp ", "adds", "subs" };

char *row5Opnames[] = {"ands", "eors", "lsls", "lsrs", "asrs", "adcs", "sbcs", "rors", "tst ", "rsbs", "cmp ", "cmn ", "orrs", "muls", "bics", "mvns"};

void printAssembly(unsigned int inst) {
    int typesOne = typesOne(inst);
    int typesTwo = typesTwo(inst);
    int typesThree = typesThree(inst);
    int types = types(inst);
    
    int immThree = imm3(inst);
    int immFive = imm5(inst);
    int immEight = imm8(inst);
    
    int row1Rd = row1Rd(inst);
    int row1Rm = row1Rm(inst);
    int row1Opcode = row1Opcode(inst);
    
    int row2_3Opc = row2_3Opc(inst);
    int row2_3Rd = row2_3Rd(inst);
    int row2_3Rm = row2_3Rm(inst);
    int row2_3Rn = row2_3Rn(inst);
    
    int row4Rdn = row4Rdn(inst);
    int row4Opcode = row4Opcode(inst);
    
    int row5Opcode = row5Opcode(inst);
    int row5Rdn = row5Rdn(inst);
    int row5Rm = row5Rm(inst);
    
    if (typesOne == 0 && typesTwo < 3) {
        /*
         * Shift by immediate, move register (row 1)
         */
        if (row1Opcode == 0 && immFive == 0) {
            /*
             * Move instruction
             */
            printf("   %s %s,%s\n", row1Opnames[3], regnames[row1Rd], regnames[row1Rm]);
        } else if (row1Opcode == 0 && immFive != 0) {
            printf("   %s %s,%s,%d\n", row1Opnames[row1Opcode], regnames[row1Rd], regnames[row1Rm], immFive);
        } else if (row1Opcode != 0 && immFive != 0)  {
            printf("   %s %s,%s,%d\n", row1Opnames[row1Opcode], regnames[row1Rd], regnames[row1Rm], immFive);
        } else {
            goto error;
        }
    } else if (typesOne == 0 && typesTwo == 3) {
        /*
         * Add/Subtract Register & Immediate (Row 2 & 3)
         */
        if (typesThree == 0) {
            /*
             * Add/Subtract Register (Row 2)
             */
            printf("   %s %s,%s,%s\n", row4Opnames[row2_3Opc + 2], regnames[row2_3Rd], regnames[row2_3Rn], regnames[row2_3Rm]);
        } else if (typesThree == 1 && immThree != 0 && (row2_3Rd != row2_3Rn)) {
            /*
             * Add/Subtract Immediate (Row 3)
             */
            printf("   %s %s,%s,%d\n", row4Opnames[row2_3Opc + 2], regnames[row2_3Rd], regnames[row2_3Rn], immThree);
        } else {
            goto error;
        }
    } else if (typesOne == 1) {
        /*
         * Add/Subtract/Compare/Move Immediate (Row 4)
         */
        if (row4Opcode < 2) {
            printf("   %s %s,%d\n", row4Opnames[row4Opcode], regnames[row4Rdn], immEight);
        } else if (row4Opcode > 1 && immEight != 0) {
            printf("   %s %s,%d\n", row4Opnames[row4Opcode], regnames[row4Rdn], immEight);
        } else {
            goto error;
        }
    } else if (typesOne == 2 && types == 16) {
        /*
         * Data-Processing Register (Row 5)
         */
        
        if (row5Opcode == 9) {
            printf("   %s %s,%s,0\n", row5Opnames[row5Opcode], regnames[row5Rdn], regnames[row5Rm]);
        } else {
            printf("   %s %s,%s\n", row5Opnames[row5Opcode], regnames[row5Rdn], regnames[row5Rm]);
        }
    } else {
        /*
         * Decoding Not Supported
         */
        
    error: printf(".hword 0x%04x\n", inst);
    }
}

void main(void) {
    unsigned int inst;
    printf(".text\n.syntax unified\n.thumb\n");
    while (scanf("%x", &inst) == 1) {
        printAssembly(inst);
    }
}
