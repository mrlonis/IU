#include<stdio.h>

int main(void) {
  int count = 10,x;
  int *countPtr;

  countPtr = &count; // countPtr = 1002ac
  x = *countPtr; // x = 10

  printf("value of count = %d, *countPtr = %d\n, countPtr - %x\n", count, *countPtr, countPtr);
}
