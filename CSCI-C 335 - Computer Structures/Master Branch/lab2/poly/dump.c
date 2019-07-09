/**
 * dump.c
 *
 * This is dump.c
 * 
 * Created By: Matthew Lonis (mrlonis)
 * Created On: 08/30/2017
 * Last Modified By: Matthew Lonis (mrlonis)
 * Last Modified On: 08/30/2017
 *
 * Assignent: Lab 2
 *
 * Part of:
 */

#include <stdio.h>

void dump_memory(void *p, int len) {
  int i;

  printf("Address      char  hexCh  short      integer          float     doubleFloat\n");

  for (i = 0; i < len; i++) {
    unsigned char currentChar = *(unsigned char *)(p + i);
    short currentShort = *(short *)(p + i);
    int currentInt = *(int *)(p + i);
    float currentFloat = *(float *)(p + i);
    double currentDouble = *(double *)(p + i);

    if ((int) currentChar < 32 || (int) currentChar > 126) {
      currentChar = '?';
    }

    /*
     * Check if i is odd. If so, don't print anything past hexCh
     */
    if (i % 2 != 0) {
      printf("%8p: %c  0x%02hhx\n",
	     p + i,
	     currentChar,
	     currentChar);
      /*
       * Check if i is divisible by 8, if it is print everything
       */
    } else if (i % 8 == 0) {
      printf("%8p: %c  0x%02hhx  %+6hd  %+11d  %+8e  %+#8e\n",
	     p + i,
	     currentChar,
	     currentChar,
	     currentShort,
	     currentInt,
	     currentFloat,
	     currentDouble);
      /*
       * Check if i is divisible by 4, if it is print everything but doubleFloat
       */
    } else if (i % 4 == 0) {
      printf("%8p: %c  0x%02hhx  %+6hd  %+11d  %+#8e\n",
	     p + i,
	     currentChar,
	     currentChar,
	     currentShort,
	     currentInt,
	     currentFloat);
      /*
       * Check if i is divisible by 2, if it is print everything up to short
       */
    } else if (i % 2 == 0) {
      printf("%8p: %c  0x%02hhx  %+6hd\n",
	     p + i,
	     currentChar,
	     currentChar,
	     currentShort);
      /*
       * Print everything
       */
    } else {
      printf("%8p: %c  0x%02hhx  %+6hd  %+11d  %+8e  %+8e\n",
	     p + i,
	     currentChar,
	     currentChar,
	     currentShort,
	     currentInt,
	     currentFloat,
	     currentDouble);
    }
  }
}
