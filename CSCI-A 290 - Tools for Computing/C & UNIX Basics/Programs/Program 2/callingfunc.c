/* Filename: callingfunc.c *
 * Part of: Program 2 *
 * Created by: Matthew Lonis *
 * Created on: 09/13/2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: 09/13/2016 *
 */

#include <stdio.h>

/* Loop function from meeting 4 */

void loops(void) {
  
  /* Declaring variables */

  int i, x;
  x = 0;

  /* for loop: runs for values of i = 0, 1, 2, and 3 */

  printf("This is a \"for\" loop\n");

  for (i = 0; i < 4; i++) {
    x = x + i;
    printf("The value of x is: %d\n", x);
  }

  printf("\n");

  /* While loop runs until i is less than 7, but what is the starting value of i for this loop? */

  /* The value of i before the while loop is 4 */

  printf("This is a \"while\" loop\n");

  while (i < 7) {
    x = x + i;
    i++;
    printf("The value of x is: %d\n", x);
  }

  printf("\n");

  /* do-while loop tuns until i is less than 9, but runs at least once. What is the starting value of i for this loop? */

  /* The value of i before the do-while loop is 7 */

  printf("This is a \"do-while\" loop\n");

  do {
    x = x + i;
    i++;
    printf("The value of x is: %d\n", x);
  } while (i < 9);

  printf("\n");

}

/* End of loop function from meeting 4 */

/* Conditional function from meeting 4 */

void conditionals(void) {
  
  /* Declaring variables */

  int i, x;
  x = 0;

  /* This for loop runs while i is less than 5 */
  
  for (i = 0; i < 5; i++) {
    if (i%2 == 0 || i == 1) {
      x = x + i;
    } else {
      x = x - i;
    }
  }
    
  printf("The value of x is: %d\n", x);
  printf("\n");
  
  /* An example of switch-case. Notice the cases are "grades" but they are looking for values that are ints */
  
  printf("This is a \"switch-case\" conditional\n");

  int grade;

  printf("Input Grade: [5 = A, 4 = B, 3 = C, 2 = D, 1 = F] \n");
  scanf("%d", &grade);
  printf("\n");
  
  switch (grade) {
  case 1:
    printf("Fail (F)\n");
    break;
  case 2:
    printf("Not Good (D)\n");
    break;
  case 3:
    printf("Good (C)\n");
    break;
  case 4:
    printf("Very Good (B)\n");
    break;
  case 5:
    printf("Excellent (A)\n");
    break;
  default:
    printf("You have not provided a valid grade value.\n");
    break;
  }
  
}

/* End of conditional function from meeting 4 */

/* Beginning of main function */

int main(void) {
  
  printf("THIS IS MY LOOPS FUNCTION.\n\n");
  loops();
  printf("THIS IS MY CONDITIONALS FUNCTION.\n\n");
  conditionals();
  
  return 0;
  
}

/* End of main function */

/* End of callingfunc.c */
