#include <stdio.h>
#include <math.h>

/* Main method */

int main(void) {

  /* Variable Declarations */

  double a = 1;
  double b = 0;
  double c = 0;
  double d = 0;
  double e = 0;
  double f = 0;

  /* Infinite for loop */
  while(1) {
    /* Printing 'Hello World' */
    printf("Hello World!\n");

    /* Waiting for three seconds */
    sleep(3);

    /* Crazy Code!! */

    a++;
    b--;
    c = a + b;
    d = sqrt(c);
    e = pow(c, d);
    f = log(a);
  }

  /* End While Loop */

  return(0);

}

/* End of main */
