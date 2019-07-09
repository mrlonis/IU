/*Filename: A1deprec.c *
 *Part of: Assignment 1 *
 *Created by: Matthew Lonis *
 *Created on: 09/07/2016 *
 *Last Modified by: Matthew Lonis *
 *Last Modified on: 09/12/2016 *
 */

#include <stdio.h>

int main(void) {

  double price, year, deprec, value; // Initializing variables to be used in the program file

  printf("Enter the purchase price, years of service, and annual depreciation with each number separated by a space:\n\n"); //Directions and instructions for the program for the user to understand what this executable does

  /*

    ..This code represents my original attempt at solving this problem in a more user friendly way. My current code reflects my attempt at replicating the sample output given to me in the assignment description..

  printf("Purchase price: ");
  scanf("%lf", &price);
  printf("\n");

  printf("Years of service: ");
  scanf("%lf", &year);
  printf("\n");

  printf("Annual depreciation: ");
  scanf("%lf", &deprec);
  printf("\n");
  */

  /*Math to determine the savage value of the car or item*/

  scanf("%lf %lf %lf", &price, &year, &deprec); //Scanf line to take input from user

  printf("\n"); //Creates a newline soley for looks

  value = price - (deprec * year); // Math for value

  printf("The salvage value of the item is %lf\n", value); //Printing the value for the user to see

  return 0; //Return zero to satisfy my 'int main(void)' function syntax
}
