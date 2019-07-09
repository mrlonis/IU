#include <stdio.h>

extern int or(int, int);

int data[] = {0x01, 0x04, 0x05, 0x0A };

void main() {
  int i=0;
  while (i < 3) {
    printf("0x%x OR 0x%x = 0x%x\n",
	   data[i], data[i+1],
	   or(data[i], data[i+1]));
    i += 1; }
}

