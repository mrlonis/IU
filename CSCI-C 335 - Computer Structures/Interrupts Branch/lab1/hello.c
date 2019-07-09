#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
  /* Infinite for loop */
  while(1) {
    /* Printing 'Hello World' */
    printf("Hello World!\n");

    /* Waiting for three seconds */
    sleep(3);
  }
}
