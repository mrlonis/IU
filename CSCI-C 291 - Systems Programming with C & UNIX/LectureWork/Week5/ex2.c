#include<stdio.h>

typedef struct user {
  int index;
  char * fname;
  char * lname;
} user_t;

void modify_user ( user_t * u, int index, char * fname, char * lname) {
  u->index = index;
  u->fname = fname;
  u->lname = lname;
}

void main (void) {
  user_t users[100];
  users[0].index = 1;
  users[0].fname = "John";
  users[0].lname = "Smith";
  printf("Index %d's name is: %s %s\n", users[0].index, users[0].fname, users[0].lname);

  modify_user(&users[0], 1, "Joe", "Doe");
  printf("Index %d's name is: %s %s\n", users[0].index, users[0].fname, users[0].lname);
}
