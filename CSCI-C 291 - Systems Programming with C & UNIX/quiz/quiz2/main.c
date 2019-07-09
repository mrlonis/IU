/* main.c */

#include <stdio.h>
#include <stdlib.h>
#include "node.h"

struct Node * list_insert(struct Node *list, struct Node *new) {
  // Remove this code when you add your code
  printf("Your insert code goes here ... \n");
  return (list);
  // End remove
}

int print_list(struct Node *list) {
  while (list) {
    printf("item = %d, Pointer = %p\n", list->item, list->next); 
    list = list->next;
  }
}

int main() {
  int i;
  struct Node *current;
  struct Node *head;
  struct Node new = {.item = 5, .next = NULL};
  head = NULL;
  for (i=1;i<10;i++) {
    current = (struct Node *) malloc(sizeof(struct Node));
    current->item = i * 2;
    current->next = head;
    head = current;
  }
  printf("Before Insert\n");
  print_list(head);
  head = list_insert(head, &new);
  printf("After Insert\n");
  print_list(head);
}



/* main.c ends here */
