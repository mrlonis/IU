#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "node.h"
#include "operations.h"

struct node *current = NULL;
struct node *head = NULL;

void main(void) {
  int main_option;
    
  while (main_option != 4) {
    printf("Enter your option: \n\n");
    printf("    1. Push\n");
    printf("    2. Pop\n");
    printf("    3. Peek\n");
    printf("    4. Exit\n\n");
    
    scanf(" %d", &main_option);
    printf("\n");
    
    if (main_option == 1) {
      int option_1_value;
      
      printf("Enter an element to push: \n\n");
      scanf(" %d", &option_1_value);
      printf("\n");
      
      head = push(head, option_1_value);
    } else if (main_option == 2) {
      head = pop(head);
    } else if (main_option == 3) {
      peek(head);
    } else {
      break;
    }
  }
}
