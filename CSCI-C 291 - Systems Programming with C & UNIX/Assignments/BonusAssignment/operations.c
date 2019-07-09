#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "node.h"

struct node * push(struct node *head, int value) {
   struct node *link = (struct node*) malloc(sizeof(struct node));
  
  link->value = value;
  link->next = head;
  head = link;
  return head;
}

struct node * pop(struct node *head) {
  if (head == NULL) {
    printf("The stack is empty\n\n");
  } else {
    int value = head->value;
    head = head->next;
    printf("Removed element %d\n\n", value);
  }
  return head;
}

void peek(struct node *head) {
  if (head == NULL) {
    printf("The stack is empty\n\n");
  } else {
    int value = head ->value;
    printf("The top element is %d\n\n", value);
  }
}

