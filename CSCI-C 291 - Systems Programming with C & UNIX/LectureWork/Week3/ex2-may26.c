#include<stdio.h>

void swap(int *swap1, int *swap2) {
  int temp;
  temp = *swap1;
  *swap1 = *swap2;
  *swap2 = temp;
}

int main(void) {

  int num1, num2; // num1=10 num2=20
  printf("Enter the first number\n");
  scanf("%d",&num1);
  printf("Enter the second number\n");
  scanf("%d",&num2);
  printf("The numbers before swapping\n");
  printf(" num1 = %d , num2 = %d\n",num1,num2);
  swap(&num1, &num2);
  printf("The numbers after swapping\n");
  printf(" num1 = %d , num2 = %d", num1, num2);
  return 0;
}
  
