/* Filename: buffet.c *
 * Part of: First A290C program *
 * Created by: Matthew Lonis *
 * Created on: 8/24/2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: 8/31/2016 *
*/

#include <stdio.h>

int main(void) {

   /* Declaring some initial variables of different data types */

   int x, y;
   char a;
   float f, e;
   double d;

   /* Assigning values to the above declared variables  */

   x = 4;
   y = 7;
   a = 'H';
   f = -3.4;
   d = 54.123456789;
   e = 54.123456789;

   /* Printf statements detailing the memory size of various different data types */

   printf("sizeof(char) == %d\n", sizeof(char));
   printf("sizeof(short) == %d\n", sizeof(short));
   printf("sizeof(int) == %d\n", sizeof(int));
   printf("sizeof(long) == %d\n", sizeof(long));
   printf("sizeof(float) == %d\n", sizeof(float));
   printf("sizeof(double) == %d\n", sizeof(double));
   printf("sizeof(long double) == %d\n", sizeof(long double));
   printf("sizeof(long long) == %d\n", sizeof(long long));
   printf("%d %c %f %lf\n", x, a, e, d);
   printf("%d %c %.9f %.9lf\n", x, a, e, d);

   /* Declaring some new variables to be used in mathematical functions  */

   int r1, r2, r3, r4, r5;
   
   /* Assigning values to the declared variables  */

   r1 = x + y;
   r2 = x - y;
   r3 = x/y;
   r4 = x * y;

   /* Print out the values of the above variables */

   printf("%d %d %d %d\n", r1, r2, r3, r4);

   /* change values of a few more variables */

   r3++;
   r4--;
   r5 = r4 % r1;

   /* Print out the new values for the user to see */

   printf("%d %d %d\n", r3, r4, r5);
   
   /* Declare new variables to be used in upcoming loop */ 

   int i, j, number;

   /* Get input from user */

   printf("Enter a number: ");
   scanf("%d", &number);

   /* Initializing i and starting loop */

   i = 1;
   
   while (i*i <= number) {
     j = 1; /* Initializing j */
     while (j <= i) /* Added = sign to the right of the < sign to account for the bug in the loop not finding multiple solutions of squares in a number */
       {
	 if (i*i + j*j == number) /* If i squared plus j squared equals the number, then print out the follwoing statement... */
	   printf("Found: %d + %d\n", i*i, j*j); /* Prints a found combo */
	 j++; /* Increment j */
       }
     i++; /* Increment i */
   }
   return (0); /*Return zero*/
}
