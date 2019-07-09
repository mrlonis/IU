#include <stdio.h>

int mystrncmp (char *s1, char *s2, int n) {
  n--;
  while((*s1)&&(*s2)&&(n)){
    if (*s1 - *s2){
      break;
    }
    else {
      s1++;
      s2++;
      n--;
    }
  }
  return(*s1-*s2);
}

void main(void) {
  char s1[] = "Hello world";
  char s2[] = "Hel";
  int retval = 0;
  retval = mystrncmp(s1, s2, 5);
}
