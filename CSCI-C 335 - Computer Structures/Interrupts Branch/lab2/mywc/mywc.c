/**
 * mywc.c
 *
 * This is mywc.c program.
 * 
 * Created By: Matthew Lonis (mrlonis)
 * Created On: 08/30/2017
 * Last Modified By: Matthew Lonis (mrlonis)
 * Last Modified On: 09/01/2017
 *
 * Assignent: Lab 2
 *
 * Part of: My wc program
 */

#include <stdio.h>

int main(void) {
  /*
   * Instructions/Welcome Message
   *
   * Ask if this is okay to have or if it needs to be taken out
   *
   */
  printf("Welcome to my version of wc!\n\n");
  printf("In order to use this program, do the following:\n\n");
  printf("     - Input any text in the terminal.\n");
  printf("     - Press enter whenever you wish to start a new line of text.\n");
  printf("     - When you are done entering text, input an EOF character on its own line.\n");
  printf("            - On a Mac: press Control+D\n");
  printf("            - On a PC: press Control+Z\n\n");

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
  while ((c = getchar()) != EOF) {
    
    characters++;

    /*
     * If statements to process special case inputs
     *
     * Ask if Vertical tab ('\v') should indicate a word or if it also indicates a new line or set of lines.
     *
     * Ask if form feed ('\f') shoul indicate a word and a a line or set of lines OR if it only signals a new word.
     *
     */
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
