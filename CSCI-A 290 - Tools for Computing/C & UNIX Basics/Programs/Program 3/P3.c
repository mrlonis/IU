/* Filename: P3.c *
 * Part of: Program 3 *
 * Created by: Matthew Lonis *
 * Created on: 9/28/2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: 9/28/2016 *
 */

#include <stdio.h>
#include <string.h>
#include <math.h>

/* Declaring Function Prototypes */

int bitmodels(void);

int pointers(void);

int morepointers(void);

int division(int numerator, int denominator, int *dividend, int *remainder);
int pointerfunction(void);

int pointerfunction(void);

int pointerarray(void);

/* End of Function Prototypes */

/* main */

int main(void) {
  /* Declaring variables */

  int loop, choice;
  loop = 1;

  printf("Welcome to my Program 3 Assignment!\n\n");

  while(loop != 0) {
    printf("What function would you like to see?\n");
    printf("     1. bitmodels.c\n");
    printf("     2. pointers.c\n");
    printf("     3. morepointers.c\n");
    printf("     4. pointerfunction.c\n");
    printf("     5. pointerarithmetic.c\n");
    printf("     6. pointerarray.c\n");
    printf("     7. Exit\n\n");

    printf(" Choice: ");
    scanf("%d", &choice);
    printf("\n");

    if (choice == 1) {
      bitmodels();
    } else if (choice == 2) {
      pointers();
    } else if (choice == 3) {
      morepointers();
    } else if (choice == 4) {
      pointerfunction();
    } else if (choice == 5) {
      pointerarithmetic();
    } else if (choice == 6) {
      pointerarray();
    } else if (choice == 7) {
      loop = 0;
    } else {
      printf("Invalid choice. Please give us a number 1-7.\n\n");
    }
  }
  return (0);
}

/* End of main */

/* bitmodels */

int bitmodels(void) {
  /* Declaring some variables of different types */

  unsigned char a, b, c, d, e;
  char f;
  int i;

  /* Various bitwise operations */

  /* NOT */

  a = 17;
  a = ~a;
  printf("bitwise NOT of 17\n");
  printf("%d\n\n", a);

  /* AND */

  b = 17;
  c = 22;
  b = b & c;
  printf("bitwise AND of 17 and 22\n");
  printf("%d\n\n", b);

  /* OR */

  d = 17;
  e = 22;
  d = d | e;
  printf("bitwise OR of 17 and 22\n");
  printf("%d\n\n", d);

  /* Set */

  f = 17;
  f = f | (1 << 3); /* Set bit #3 */
  printf("Sets bit #3 in 17, new value is 17 + 8 = 25\n");
  printf("%d\n\n", f);

  /* Clear */

  f = f & (~(1 << 4)); /* Clears bit #4 */
  printf("Clears bit #4 in 25, new value is 25 - 16 = 9\n");
  printf("%d\n\n", f);

  /* Check/display each bit value */

  printf("Reads i-th bit in current value of f (which is the base10 number 9), plus a loop that prints every bit in 8-bit space\n");

  for (i = 7; i >= 0; i--) {
    printf("%d ", (f & (1 << i)) >> i); /* Read i-th bit */
  }
  printf("\n\n");

  printf("Current value of a\n");

  for (i = 7; i >= 0; i--) {
    printf("%d ", (a & (1 << i)) >> i); /* Read i-th bit */
  }
  printf("\n\n");

  printf("Current value of d\n");

  for (i = 7; i >= 0; i--) {
    printf("%d ", (d & (1 << i)) >> i); /* Read i-th bit */
  }
  printf("\n\n");

  printf("Current value of e\n");

  for (i = 7; i >= 0; i--) {
    printf("%d ", (e & (1 << i)) >> i); /* Read i-th bit */
  }
  printf("\n\n");

  return (0);
}

/* End of bitmodels */

/* pointers */

int pointers(void) {
  /* Variable Declarations */

  int count, x;
  int *count_p;

  char letter;
  char *letter_p = &letter;

  /* Assigning values to declared variables */

  count = 10;
  count_p = &count;
  x = *count_p;
  letter = 'Q';

  /* Print contents of count and x */

  printf("Here's the step-by-step output from the integer pointer example\n\n");

  /* Let's confirm the values of count and x */

  printf("count = %i and x = %i\n\n", count, x);

  /* Let's change count using the pointer count_p */

  *count_p = 42;

  /* Let's print the contents of count and x again */

  printf("count = %i and x = %i\n\n", count, x);

  /* Let's change count to the value of x */

  count = x;

  /* Let's print the contents of count and x again */

  printf("count = %i and x = %i\n\n", count, x);

  printf("Here's the step-by-step output from the character pointer example\n\n");

  /* Let's confirm the values of letter and letter_p */
  
  printf("letter = %c and letter_p = %c\n\n", letter, *letter_p);

  /* Let's change letter but not letter_p */

  letter = '/';

  /* Let's print the contents of letter and leter_p again */

  printf("letter = %c and letter_p = %c\n\n", letter, *letter_p);
  
  /* Let's change letter_p but not letter */

  *letter_p = '!';

  /* Let's print the contents of letter and letter_p again */

  printf("letter = %c and letter_p = %c\n\n", letter, *letter_p);

  return (0);
}

/* End of pointers */

/* morepointers */

int morepointers(void) {
  /* Variable Declaration */

  int firsti, secondi;
  int *firsti_p, *secondi_p;

  /* Assigning values to the declared variables */

  firsti = 5;
  firsti_p = &firsti;
  secondi = *firsti_p / 2 + 10;
  secondi_p = firsti_p;

  /* Let's print the outcome of our first set of int and int pointers */

  printf("Here's the output from the first integer pointer example\n\n");

  /* Let's confirm all the values */

  printf("firsti = %i, secondi = %i, value of firsti_p = %i, and value of secondi_p = %i\n\n", firsti, secondi, *firsti_p, *secondi_p);

  return (0);
}

/* End of morepointers */

/* division */

int division(int numerator, int denominator, int *dividend, int *remainder) {

  printf("address stored in dividend: %u\n\n");
  printf("address stored in remainder: %u\n\n");

  if (denominator < 1) {
    return (0);
  } else {
    *dividend = numerator / denominator;
    *remainder = numerator % denominator;
    numerator = 7;
  }
}

/* End of division */

/* pointerfunction */

int pointerfunction(void) {
  /* Declaring Variables */

  int x, y, d, r;

  x = 9;
  y = 2;

  printf("address of d: %u\n\n", &d); /* Address where dividend in function should point */
  printf("address of r: %u\n\n", &r); /* Address where remainder in function should point */

  division(x, y, &d, &r);
  printf("%d/%d = %d with %d remainder\n\n", x, y, d, r);
  printf("x = %d\n\n", x);
  
  return (0);
}

/* End of pointerfunction */

/* pointerarithmetic */

int pointerarithmetic(void) {
  /* Declaring Variables */

  char ca[3], *cp;
  int ia[3], *ip;

  /* Assigning values */

  ca[0] = 'A';
  ca[1] = 'B';
  ca[2] = 'c';
  cp = &(ca[0]);

  ia[0] = 1234;
  ia[1] = 5678;
  ia[2] = 9999;
  ip = &(ia[0]);

  /* Show output, then use pointers, then show output again. */

  printf("char pointer cp points to value = %c\n", *cp);
  printf("ca[2] = %c\n\n", ca[2]);
  printf("int point ip points to value = %i\n", *ip);
  printf("ia[2] = %i\n\n", ia[2]);

  *(cp+2) = 'Q';
  *(ip+2) = 33;

  printf("Results after we apply pointer arithmetic.\n");
  printf("ca[2] = %c\n", ca[2]);
  printf("ia[2] = %i\n\n", ia[2]);

  return (0);
}

/* End of pointerarithmetic */

/* pointerarray */

int pointerarray(void) {
  double array[10];
  double *d_ptr;
  double value;
  int i, offset;

  for (i = 0; i < 10; i++) {
    array[i] = (double)i + 10.0; /* Access memory using array index and fill cells with #s */
    d_ptr = &(array[0]); /* Access memory location of first array cell using pointer */
  }

  while (1) {
    printf("\nAddress (hex) \tAddress (base10) \tValue\n");

    for (i = 0; i < 10; i++) {
      printf("%p\t%u\t%lf\n", &(array[i]), &(array[i]), array[i]);
    }
    printf("\n");
    
    printf("Enter offset value (0 0 to quit): ");
    scanf("%d %lf", &offset, &value);
    printf("\n");

    if (offset == 0 && value == 0.0) {
      break; /* Break out of loop */
    } else if (offset < 0 || offset > 9) {
      printf("Offset out of bounds\n");
      continue; /* Go back to start of loop */
    } else {
    }
    /* Three ways to do the same thing */
    
    array[offset] = value; /* Using array syntax */
    /* *(d_ptr + offset) = value; // Using pointer syntax */
    /* *(array + offset) = value; // Using mixed syntax */
  }
  return (0);
}

/* End of pointerarray */

/* End of P3.c */
