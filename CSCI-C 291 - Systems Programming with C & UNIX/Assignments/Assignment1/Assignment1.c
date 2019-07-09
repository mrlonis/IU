#include<stdio.h>
#include<math.h>

int power(int, int);

int main (void) {
  int n, sum = 0, temp,  remainder, digits = 0;
  
  printf ("An Armstrong number is a number that is an n-digit number that is equal to the sum of the nth powers of its digits. ");
  printf ("Enter a positive integer and I will tell you if it is an Armstrong number or not: ");
  scanf ("%d", &n);

  temp = n; /*Count the number of digits*/

  while (temp != 0) {
    digits++;
    temp /= 10;
  }

  temp = n;

  while (temp!= 0) {
    remainder = temp % 10;
    sum += power(remainder, digits);
    temp /= 10;
  }

  if (n == sum)
    printf("%d is an Armstrong number.\n", n);
  else
    printf("%d is not an Armstrong number.\n", n);
}

int power(int n, int r) {
  int c, p = 1;

  for (c = 1; c<= r; c++)
    p *= n;

  return p;
}
