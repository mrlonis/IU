#include <stdio.h>

extern void *alloc(int);
extern void dealloc(void *);
/*
extern void *sbrk(int);

void *malloc(int size) {
  void *block;
  block = sbrk(size);
  if (block == (void*) - 1)
    return NULL;
  return block;
}

void free(void *ptr) {}
*/


void main() {
  void *p = alloc(33);
  if (p) {
    printf("alloc succeeded\n");
    dealloc(p);
  }
  else
    printf("alloc failed\n");

}

