#include<stdio.h>

struct tag {
  char lname[20];
  char fname[20];
};

struct tag names[100];

void print_tags(struct tag *n, int size) {
  int i;
  for(i=0; i < size; i++){
    printf("%s, %s\n", n->lname, n->fname);
    n++;
  }
}

void main(void) {
  print_tags(&names[0], 50);
}
