#include<stdio.h>
#include<math.h>

int decimal_to_octal (int number) {
    int remainder, i = 1, octal = 0;
    while (number != 0) {
      remainder = number % 8;
      number /= 8;
      octal += remainder * i;
      i *= 10;
    }
    return octal;
}

int octal_to_binary (int number) {
  int decimal = 0, binary = 0, i = 0;
  while (number != 0) {
    decimal += (number % 10) * pow (8, i);
    ++i;
    number /= 10;
  } /* At this point, the decimal variable contains the corresponding decimal value of the octal number that was given in the argument. */
  i = 1;
  while (decimal != 0) {
    binary += (decimal % 2) * i;
    decimal /= 2;
    i *= 10;
  }
  return binary;
}

int main(void) {

  int input_1, input_2;
  char choice;
  printf("Enter a decimal number: ");
  scanf("%d", &input_1);

  printf("Enter another decimal number to be added or multiplied to the first number: ");
  scanf("%d", &input_2);

  printf("Enter 'a' to add or 'm' to multiply the first number to the second number: ");
  scanf(" %c", &choice);

  if (choice == 'a' || choice == 'A'){
    int octal_1 = decimal_to_octal(input_1);
    int octal_2 = decimal_to_octal(input_2);
    int op_num = octal_1 + octal_2;
    int result = octal_to_binary(op_num);
    printf("The result in binary is %u\n", result);
  } else {
    int octal_1 = decimal_to_octal(input_1);
    int octal_2 = decimal_to_octal(input_2);
    int op_num = octal_1 * octal_2;
    int result = octal_to_binary(op_num);
    printf("The result in binary is %u\n", result);
  }
}
