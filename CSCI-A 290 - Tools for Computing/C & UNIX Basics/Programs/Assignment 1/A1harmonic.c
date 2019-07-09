/* Filename: A1harmonic.c *
 * Part of: Assignment 1 *
 * Created by: Matthew Lonis *
 * Created on: 09/12/2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: 09/12/2016 *
 */

#include <stdio.h>

int main(void) {

  /*Initializing variables to be used in the program*/

  int number, i;
  double sum = 0;

  printf("Enter a value to calculate the value of this harmonic series:\n\n"); // Instructions for user

  scanf("%d", &number); // Receieve input
  printf("\n");

  /*Checks if given number is negative, if it is it will ask for a new positive number, otherwise it does nothing*/

  if (number <= 0) {
    printf("Please enter a POSITIVE number : ");
    scanf("%d", &number);
    printf("\n");
  }

  /*Sums up the harmonic sequence using a loop*/

  for (i = 1; i <= number; i++) {
    sum += 1/(double)i; // Double is necesary because i is an int, it needs to be cast to a double to ensure the accuracy of our result
  }

  printf("The value of the series is: %lf\n", sum); // Display result to user

  return 0; // Return 0 to satisfy the main

}

/* End of A1harmonic.c */
