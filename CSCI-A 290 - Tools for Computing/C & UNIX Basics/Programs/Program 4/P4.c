/* Filename: P4.c *
 * Part of: Program 4 *
 * Created by: Matthew Lonis *
 * Created on: 10/05/2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: 10/05/2016 *
 */

/* Libraries */

#include<stdlib.h>
#include<string.h>
#include<math.h>
#include<stdio.h>

/* End of Libraries */

/* Function Prototypes */

int program4(void); //Will run content from meeting 11

struct person; // Declaring person as an incomplete type to satisfy function prototype of DisplayStats

void DisplayStats(struct person class); 

struct NODE; //Same as other struct

void append_node(struct NODE *llist, int num);
void delete_node(struct NODE *llist, int num);
int search_value(struct NODE *llist, int num);
void display_list(struct NODE *llist);

int linked_list(void); //Will run meeting 12 content

/* End of Function Prototypes */

/* Structures */

/* person Structure */

struct person {
  char first[32];
  char last[32];
  int year;
  double ppg;
};

/* NODE Structure */

struct NODE {
  int number;
  struct NODE *next;
};

/* End of Structures */

/* main() */

int main(void) {
  printf("\n");

  program4();
  
  printf("\n");
  
  linked_list();

  return(0);
}

/* End of main() */

/* program4() */

int program4(void) {
  /* Initial Variables */
  
  struct person class[54]; //Array of person structs
  
  /* Assigning values to the array - Person one is in array slot [0] */
  
  class[0].year = 2004;
  class[0].ppg = 5.2;
  strcpy(class[0].first, "Jane");
  strcpy(class[0].last, "Doe");

  class[1].year = 2005;
  class[1].ppg = 4.9;
  strcpy(class[1].first, "Brian");
  strcpy(class[1].last, "Smith");
  
  class[2].year = 2006;
  class[2].ppg = 6.2;
  strcpy(class[2].first, "Matthew");
  strcpy(class[2].last, "Lonis");

  class[3].year = 2007;
  class[3].ppg = 7.3;
  strcpy(class[3].first, "Mark");
  strcpy(class[3].last, "Marley");

  class[4].year = 2008;
  class[4].ppg = 8.4;
  strcpy(class[4].first, "Luke");
  strcpy(class[4].last, "Day");

  class[5].year = 2009;
  class[5].ppg = 9.5;
  strcpy(class[5].first, "John");
  strcpy(class[5].last, "Swagger");

  class[6].year = 2010;
  class[6].ppg = 1000.967;
  strcpy(class[6].first, "Jesus");
  strcpy(class[6].last, "Christ");

  /* Loop to print run DisplayStats on all the persons in the array */

  int i = 0; // Start at aray slot [0]
  while (i <= 6) { //Only going up to array slot [6] so <=
    DisplayStats(class[i]);
    i++;
  }
  return (0);
}

/* End of program4() */

/* DisplayStats(struct person class[7]) */

void DisplayStats(struct person class) {
  /* Initial Variables */

  int i = 0;
  int length_first = strlen(class.first); //Length of First name
  int length_last = strlen(class.last); // Length of last name

  /* Prints last name */
  
  while(i <= length_last) {
    printf("%c", class.last[i]);
    i++;
  }
  
  /* Comma */

  printf(", ");
  i = 0; //Reset i back to zero
  
  /* Prints last name */
  
  while(i <= length_first) {
    printf("%c", class.first[i]);
    i++;
  }
  
  /* Prints the rest of the information */
  
  printf(": %lf PPG in %d\n", class.ppg, class.year);
}

/* End of DisplayStats(struct person class[7]) */

/* append_node */

void append_node(struct NODE *llist, int num) {
  while (llist->next != NULL) {
    llist = llist->next;
  }
  llist->next = (struct NODE *)malloc(sizeof(struct NODE));
  llist->next->number = num;
  llist->next->next = NULL;
}

/* End of append_node */

/* delete_node */

void delete_node(struct NODE *llist, int num) {
  struct NODE *temp;
  temp = (struct NODE *)malloc(sizeof(struct NODE));
  
  if (llist-> number == num) {
    /* remove the node */

    temp = llist->next;
    free(llist);
    llist = temp;
  } else {
    while (llist->next->number != num) {
      llist = llist->next;
    }
    temp = llist->next->next;
    free(llist->next);
    llist->next = temp;
  }
}

/* End of delete_node */

/* search_value */

int search_value(struct NODE *llist, int num) {
  int retval = -1;
  int i = 1;

  while (llist->next != NULL) {
    if (llist->next->number == num) {
      return i;
    } else {
      i++;
    }

    llist = llist->next;
  }

  return retval;
}

/* End of search_value */

/* display_list */

void display_list(struct NODE *llist) {
  while (llist->next != NULL) {
    printf("%d->", llist->number);
    llist = llist->next;
  }

  printf("%d\n", llist->number);
}

/* End of display_list */

/* linked_list */

int linked_list(void) {
  /* Initial Variables */

  int num = 0;
  int input = 1;
  int retval = 0;
  struct NODE *llist;

  /* Initializing llist */

  llist = (struct NODE *)malloc(sizeof(struct NODE));
  llist->number = 0;
  llist->next = NULL;

  /* Menu loop */

  while (input != 0) {
    printf("\n-- Menu Selection --\n");
    printf("0. Quit\n");
    printf("1. Insert\n");
    printf("2. Delete\n");
    printf("3. Search\n");
    printf("4. Display\n\n");

    printf("Choice: ");
    scanf("%d", &input);
    printf("\n");

    /* Case switching logic */

    switch (input) {
    case 0:
      printf("Goodbye ...\n");
      input = 0;
      break;

    case 1:
      printf("Your choice: 'Insertion'\n");
      printf("Enter the value which should be inserted: ");
      scanf("%d", &num);
      printf("\n");
      append_node(llist, num);
      break;

    case 2:
      printf("Your choice: 'Deletion'\n");
      printf("Enter the value which should be deleted: ");
      scanf("%d", &num);
      if((retval = search_value(llist, num)) == -1) {
	printf("Value '%d' not found\n", num);
      } else {
	delete_node(llist, num);
      }
      break;

    case 3:
      printf("Your choice: 'Search'\n");
      printf("Enter the value you want to find: ");
      scanf("%d", &num);
      if ((retval = search_value(llist, num)) == -1) {
	printf("Value '%d' not found\n", num);
      } else {
	printf("Value '%d' located at position '%d'\n", num, retval);
      }
      break;

    case 4:
      printf("Your choice: 'Display'\n");
      display_list(llist);
      break;

    default:
      printf("That is not a valid menu option\n");
      break;
    }
  }
  free(llist);
  return(0);
}

/* End of linked_list */

/* End of P4.c */
