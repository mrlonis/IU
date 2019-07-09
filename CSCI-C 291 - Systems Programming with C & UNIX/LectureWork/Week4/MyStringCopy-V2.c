#include<stdio.h>

void main () {
  int x;
  printf("Enter a number less than 10:");
  scanf("%d", &x);
  
  char buf1[]="Hello World";
  char buf2[99];

  char *mystrcpy(char *src, char *dst, int size) {
    int i=0;
    while ((*(src+i) != '\0') && (i != size)){
      *(dst+i) = *(src+i);
      i++;
    }
    *(dst+i) = '\0';
    return dst;
  }

  char n = *mystrcpy(buf1, buf2, x);
  printf("%s\n", &n);
}
