/* Filename: a3.c *
 * Part of: Assignment 3 *
 * Created by: Matthew Lonis *
 * Creatd on: 10/03/2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: 10/04/2016 *
 */

/* Libraries necessary for this file */

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

/* Function prototypes */

int showbits(int argument);

int leftBitShift(void);
int rightBitShift(void);
int binaryAnd(void);
int binaryOr(void);
int binaryNegation(void);
int binaryXOr(void);

/* main() */

int main(void) {
  int loop, choice;
  loop = 1;

  printf("Welcome to Matthew Lonis' Assignment 3!\n\n");

  while (loop != 0) {
    printf("               Main Menu\n");
    printf("               ---------\n");
    printf("1. Perform Left Bit Shift Operation (one value)\n");
    printf("2. Perform Right Bit Shift Operation (one value)\n");
    printf("3. Perform Binary AND Operation (two values)\n");
    printf("4. Perform Binary OR Operation (two values)\n");
    printf("5. Perform Binary One's Complement (~) Operation (one value)\n");
    printf("6. Perform Binary XOR Operation (two values)\n");
    printf("7. Quit\n\n");

    printf("Enter your choice: ");
    scanf("%d", &choice);
    printf("\n");

    if (choice == 1) {
      leftBitShift();
    } else if (choice == 2) {
      rightBitShift();
    } else if (choice == 3) {
      binaryAnd();
    } else if (choice == 4) {
      binaryOr();
    } else if (choice == 5) {
      binaryNegation();
    } else if (choice == 6) {
      binaryXOr();
    } else if (choice == 7) {
      loop = 0;
    } else {
      printf("Invalid input. Number must be a number between 1 and 7.\n\n");
    }

  }

  return (0);
}

/* End of main() */

/* showbits() */

int showbits(int argument) {
  /* Initial variables */

  int count, argument_copy;
  argument_copy = argument; // Used to determine how many bits will be in argument. I am defining a second argument so i dont modify the original argument just yet
  count = 0;
  
  /* While loop counts bits based on argument to be passed to malloc later on */

  while (argument_copy >= 1) {
    argument_copy = argument_copy / 2;
    count++;
  }
  count--;

  /* Initialize Pointer Array */

  int *remainder_p;
  remainder_p = (int *)malloc(count * sizeof(int)); // Size of pointer array is based on our earlier while loop with count

  int count2 = 0;

  /* places all division remainders in an array so we can reverse the direction later */

  while (argument >= 1) {
    remainder_p[count2] = (argument % 2);
    argument = argument / 2;
    count2++;
  }
  count2--;

  /* count3 represents the amount of zeros that should be in front of our bits */

  int count3 = 30 - count;

  /* Loop prints out 0's until count is less than zero, then we will be printing our bits from the array in the next while loop */

  while (count3 >= 0) {
    printf("0");
    count3--;
  }

  /* this prints the elements in our array, just in reverse order */

  while (count >= 0) {
    printf("%d", remainder_p[count]);
    count--;
  }

  free(remainder_p); // Return allocated space malloc gave us

  return (0);
}

/* End of showbits() */

/* leftBitShift() */

int leftBitShift(void) {
  /* Initial variables */
  
  int base10, shift;

  /* take input from user */

  printf("Enter a base 10 Integer: ");
  scanf("%d", &base10);
  printf("\n");
  
  printf("Enter a number of places to shift bit: ");
  scanf("%d", &shift);
  printf("\n");

  /* display integer before and after shift */

  printf("Entered Integer: ");
  showbits(base10);
  printf(" (base 10 %d)\n", base10);
  
  printf("Left Shifted   : ");
  base10 = base10 << shift; // bitwise operator to shift bits
  showbits(base10);
  printf(" (base 10 %d)\n\n", base10);

  return (0);
}

/* End of leftBitShift() */

/* rightBitShift() */

int rightBitShift(void) {
  /* Initial variables */
  
  int base10, shift;

  /* User input */

  printf("Enter a base 10 Integer: ");
  scanf("%d", &base10);
  printf("\n");
  
  printf("Enter number of places to shift bit: ");
  scanf("%d", &shift);
  printf("\n");

  /* Display input */

  printf("Entered Integer: ");
  showbits(base10);
  printf(" (base 10 %d)\n", base10);

  printf("Right Shifted  : ");
  base10 = base10 >> shift; // Bitwise operator to shift to the right
  showbits(base10);
  printf(" (base 10 %d)\n\n", base10);

  return (0);
}

/* End of rightBitShift() */

/* binaryAnd() */

int binaryAnd(void) {
  /* Initial variables */

  int base10_1, base10_2;

  /* User input */

  printf("Enter two base 10 Integers, separated by a space: ");
  scanf("%d %d", &base10_1, &base10_2);
  printf("\n");

  /* Display results */

  printf("Entered Integer 1: ");
  showbits(base10_1);
  printf(" (base 10 %d)\n", base10_1);

  printf("Entered Integer 2: ");
  showbits(base10_2);
  printf(" (base 10 %d)\n", base10_2);

  printf("AND'ed           : ");
  int and = base10_1 & base10_2; // Bitwise operator
  showbits(and);
  printf(" (base 10 %d)\n\n", and);

  return (0);
}

/* End of binaryAnd() */

/* binaryOr() */

int binaryOr(void) {
  /* Initial variables */

  int base10_1, base10_2;

  /* User input */

  printf("Enter two base 10 Integers, separated by a space: ");
  scanf("%d %d", &base10_1, &base10_2);
  printf("\n");

  /* Display results */

  printf("Entered Integer 1: ");
  showbits(base10_1);
  printf(" (base 10 %d)\n", base10_1);

  printf("Entered Integer 2: ");
  showbits(base10_2);
  printf(" (base 10 %d)\n", base10_2);

  printf("OR'ed            : ");
  int or = base10_1 | base10_2; // Bitwise operator
  showbits(or);
  printf(" (base 10 %d)\n\n", or);

  return (0);
}

/* End of binaryOr() */

/* binaryNegation() */

int binaryNegation(void) {
  /* Initial variables */

  int base10;

  /* User input */

  printf("Enter a base 10 Integer: ");
  scanf("%d", &base10);
  printf("\n");

  /* Display results */

  printf("Entered Integer: ");
  showbits(base10);
  printf(" (base 10 %d)\n", base10);

  printf("~'ed           : ");
  base10 = ~base10; // Bitwise operator
  showbits(base10);
  printf(" (base 10 %d)\n\n", base10);

  return (0);
}

/* End of binaryNegation() */

/* binaryXOr() */

int binaryXOr(void) {
  /* Initial variables */

  int base10_1, base10_2;

  /* User input */

  printf("Enter two base 10 Integers, separated by a space: ");
  scanf("%d %d", &base10_1, &base10_2);
  printf("\n");

  /* Display results */

  printf("Entered Integer 1: ");
  showbits(base10_1);
  printf(" (base 10 %d)\n", base10_1);

  printf("Entered Integer 2: ");
  showbits(base10_2);
  printf(" (base 10 %d)\n", base10_2);

  printf("XOR'ed           : ");
  int xor = base10_1 ^ base10_2; // Bitwise operator
  showbits(xor);
  printf(" (base 10 %d)\n\n", xor);

  return (0);
}

/* End of binaryXOr() */

/* End of a3.c */
