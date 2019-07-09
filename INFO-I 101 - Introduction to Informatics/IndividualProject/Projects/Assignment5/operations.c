#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "node.h"

struct node * insert_first(struct node *head, int value) {
  
  struct node *link = (struct node*) malloc(sizeof(struct node));
  
  link->value = value;
  link->next = head;
  head = link;
  return head;
}

struct node * insert_position(struct node *head, int option_3_value, int option_3_position) {
  int i;
  struct node *temp, *left, *right;
  right = head;
  
  for (i = 0 ; i < option_3_position && right != NULL ; i++) {
    left = right;
    right = right->next;
  }
  
  temp=(struct node *)malloc(sizeof(struct node));
  
  temp->value = option_3_value;
  temp->next = right;
  left->next = temp;
  return left;
}

void print_list (struct node *head) {
  printf("\n[ ");
	
  while(head != NULL)
    {        
      printf("(%d) ", head->value);
      head = head->next;
    }
	
  printf(" ]");
  return;
}

struct node * search (struct node *head, int value){
  int position = 1;
  
  struct node* current = head;

  if(head == NULL) {
    return NULL;
  }
  
  while (current->value != value){
    
    if(current->next == NULL){
      return NULL;
    } else {
      current = current->next;
      position++;
    }
  }      
  printf("The value %d was found in the list at position %d\n\n", value, position);
}
