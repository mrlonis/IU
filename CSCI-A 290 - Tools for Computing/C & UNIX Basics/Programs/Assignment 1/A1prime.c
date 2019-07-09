/*Filename: A1prime.c *
 *Part of: Assignment 1 *
 *Created by: Matthew Lonis *
 *Created on: 09/07/2016 *
 *Last Modified by: Matthew Lonis *
 *Last Modified on: 09/12/2016 *
 */

#include <stdio.h>

int main(void) {
  
  /*Number holds the user input fr a number, i is used in the loop to determine if number is prime or not, count is used in the main for loop to allow the user to check if two numbers are prime, and prime is a variable that will either be 1 or 0; if 0 the number is prime, if 1 the number is not prime*/

  int number, i, count, prime = 0; // Initializing variables to be used
  
  for (count = 0; count != 2; count++) { // Main for loop to allow user to check two numbers instead of one. I could increase this to any number but i am following the sample output and limiting it to two numbers
    
    printf("Enter a positive integer to check if it is a prime number: \n\n");// User instructions
    scanf("%d",&number); // Taking user input
    printf("\n"); // new line for visual clarity
    
    for(i = 2; i <= number/2; ++i) { // Loop checks if number is prime by checking if the number divided by i gives out a remainder of zero for any i less than number divided by 2
      /* printf("The value of i is %d\n", i); // Test to see value of i throughout the loop - You can ignore this line*/
      if(number%i == 0) {// If number is divisible by i and leaves no remainder then it is not prime
	prime = 1; // Turns prime variable to the value 1 so in the if statements below it prints out the number isn't prime
	break; // Breaks from the loop. This is necessary because the first check is if number/2 produces a remainder of zero. So essentially if number is divisible by 2 evenly, it can never be prime
      }
    }
    
    /* printf("\n"); I added this line for visual clarity when my printf("The value of i is %d", i); line was active. This is no longer needed but i am leaving it here for the memory that i did this*/

    /*This next if statement is based on whether prime is 0 or 1. If prime is the value 0, then the numbe is a prime number, otherwise it is not a prime number*/    

    if (prime == 0) {
      printf("The number %d is a prime number.\n\n", number);
    } else {
      printf("The number %d is NOT a prime number.\n\n", number);
    }
    prime = 0; // Resetting prime back to zero. If i don't do this then if the first number given is NOT a prime number, even if the second number is prime it will say the number isn't prime
  }
  return 0; // To satisfy the main return value  
}
