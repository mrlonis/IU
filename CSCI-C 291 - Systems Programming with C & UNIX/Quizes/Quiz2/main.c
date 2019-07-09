/* main.c */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "node.h"

/*Made these global variables for easier access*/
struct Node *current;
struct Node *head = NULL;

/* inserts new node at the first position of the linked list*/
struct Node * list_insert(struct Node *list, struct Node *new) {
  new->next = list;
  list = new;
}

/*Finds length of the current list*/
int length()
{
   int length = 0;
	
   for(current = head; current != NULL; current = current->next) {
      length++;
   }
   return length;
}

/*Sorts list since i am inserting the new node at the beginning of the list*/
void sort(){

   int i, j, k, tempItem;
   struct Node *current;
   struct Node *next;
   
   int size = length();
   k = size ;
	
   for ( i = 0 ; i < size - 1 ; i++, k-- ) {
     current = head ;
     next = head->next ;
		
     for ( j = 1 ; j < k ; j++ ) {   
       
       if (current->item < next->item) {
	 tempItem = current->item;
	 current->item = next->item;
	 next->item = tempItem ;
       }
       
       current = current->next;
       next = next->next;                        
     }
   }   
}

/*Prints list*/
int print_list(struct Node *list) {
  while (list) {
    printf("item = %d, Pointer = %p\n", list->item, list->next); 
    list = list->next;
  }
}

/*The main*/
void main() {
  int i;
  
  struct Node new = {.item = 5, .next = NULL};
  
  for (i=1;i<10;i++) {
    current = (struct Node *) malloc(sizeof(struct Node));
    current->item = i * 2;
    current->next = head;
    head = current;
  }
  
  printf("Before Insert\n");
  print_list(head);
  
  head = list_insert(head, &new);
  sort();
  printf("After Insert\n");
  print_list(head);
  
}
/* main.c ends here */
