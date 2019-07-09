/* mystrcmp.c --- 
 * 
 * Filename: mystrcmp.c
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: 
 * Created: Tue May 24 10:53:29 2016
 */

/* Code: */

#include <stdio.h>
#include <string.h>

int mystrncmp(char *s1, char *s2, int n) {
  n--;
  while ((*s1) && (*s2) && n) {
    if (*s1-*s2) {
      break;
    }
    else {
      s1++;
      s2++;
      n--;
    }
  }
  return (*s1-*s2);
}

char * substring(char * string, char * substring) {
  while (*string) {
    if (!strncmp(string,substring,strlen(substring))) {
      return string;
    }
    string++;
  }
  return NULL;
}

void main(void) {
  char s1[] = "hello world";
  char s2[] = "hello world!";

  printf("libc strncmp result = %d\n",strncmp(s1,s2,30));
  printf("mystrcmp result = %d\n",mystrncmp(s1,s2,30));

  char s3[] = "hello world";
  char s4[] = "wo";
  char * p;

  p = substring(s3,s4);
  if (p) {
    printf("substring result %s\n",p);
  }
  else {
    printf("Not Found\n");
  }
}
/* mystrcmp.c ends here */
