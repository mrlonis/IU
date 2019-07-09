#include<stdio.h>

char *substring(char *string, char *sub){
  while (*string){
    if(!mystrncmp(string, substring, strlen(substring))){
      return string
	}
    string++
      }
  return(null);
}
