#include<stdio.h>

char *mystrcpy(char *src, char *dst) {
  int i = 0;
  while (*(src + i) != '\0'){
    *(dst+i) = *(src+i);
    i++;
  }
  *(dst+i) = '\0';
  return dst;
}

char main () {
  char buf1[] = "Hello World";
  char buf2[99];
  char *p;
  p = mystrcpy(buf1, buf2);
  printf("%s\n", &*p);
}
