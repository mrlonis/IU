#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "node.h"
#include "operations.h"

struct node *current = NULL;
struct node *head = NULL;

void main(void) {
  int main_option = 0, insert_on = 1;

  if (insert_on == 1) {
    
    while (main_option != 5) {
      printf("Enter your option: \n\n");
      printf("    1. Add element\n");
      printf("    2. Search\n");
      printf("    3. Insert\n");
      printf("    4. Display\n");
      printf("    5. Exit\n\n");

      scanf(" %d", &main_option);
      printf("\n");

      if (main_option == 1) {
	int option_1_value;
	
	printf("Enter the value: \n\n");
	scanf(" %d", &option_1_value);
	printf("\n");
	
	head = insert_first(head, option_1_value);
      
	printf("Value added to the list.\n\n");
      } else if (main_option == 2) {
	int option_2_value;

	printf("Enter a value to search for: \n\n");
	scanf(" %d", &option_2_value);
	printf("\n");

	search (head, option_2_value);
      } else if (main_option == 3) {
	
	int option_3_position, option_3_value;
	
	printf("Enter the position for insertion: \n(Note this must be a number from 1 to infinity and must not be larger than the linked list size)\n\n");
	scanf(" %d", &option_3_position);
	printf("\n");

	printf("Enter the value: \n\n");
	scanf(" %d", &option_3_value);
	printf("\n");
	
	head = insert_position(head, option_3_value, option_3_position);
      
	printf("Element inserted successfully\n");
	print_list(head);
	printf("\n\n");
	break;
      } else if (main_option == 4) {
	print_list(head);
      } else {
	main_option = 4;
	break;
      }
    }
    
  }
    
  while (main_option != 4) {
    printf("Enter your option: \n\n");
    printf("    1. Add element\n");
    printf("    2. Search\n");
    printf("    3. Display\n");
    printf("    4. Exit\n\n");
    
    scanf(" %d", &main_option);
    printf("\n");
    
    if (main_option == 1) {
      int option_1_value;
      
      printf("Enter the value: \n\n");
      scanf(" %d", &option_1_value);
      printf("\n");
      
      head = insert_first(head, option_1_value);
      
      printf("Value added to the list.\n\n");
    } else if (main_option == 2) {
      int option_2_value;
      
      printf("Enter a value to search for: \n\n");
      scanf(" %d", &option_2_value);
      printf("\n");
      
      search (head, option_2_value);
    } else if (main_option == 3) {
      print_list(head);
    } else if (main_option == 4) {
      break;
    } else {
    }
  }
}
