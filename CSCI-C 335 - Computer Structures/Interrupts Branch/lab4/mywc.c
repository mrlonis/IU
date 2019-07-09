/**
 * mywc.c
 *
 * This is mywc.c program.
 * 
 * Created By: Matthew Lonis (mrlonis)
 * Created On: 08/30/2017
 * Last Modified By: Matthew Lonis (mrlonis)
 * Last Modified On: 09/15/2017
 *
 * Assignent: Lab 2
 *
 * Part of: My wc program
 */

#include <f3d_uart.h>
#include <stdio.h>

int mywc(void) {
  /*
   * Variable Declarations/Initializations
   */
  int c;
  int lines = 0;
  int words = 0;
  int characters = 0;

  /*
   * While loop to get/process stdin
   */
  while ( ( c = getchar() ) != 0x1b ) {
    putchar(c);

    characters++;

    if ((char) c == ' ' || (char) c == '\t' || (char) c == '\v') {
      words++;
    } else if ((char) c == '\n' || (char) c == '\r' || (char) c == '\f') {
      words++;
      lines++;
    }
  }

  /*
   * printf statement to display wc results.
   */
  printf("\n     %d     %d     %d\n", lines, words, characters);
}
