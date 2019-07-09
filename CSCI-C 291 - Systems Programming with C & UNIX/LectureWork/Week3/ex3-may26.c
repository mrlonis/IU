#include<stdio.h>

#define N 5

int main(void) {
  int i, j, aa[N];

  for (i = 0; i < N; i++) {
    aa[i] = i * i;
    printf("*(aa + %d) = %d; aa[%d] = %d\n", i, *(aa + i), i, aa[i]);
  }
}
