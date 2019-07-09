/* Filename: A4.c *
 * Part of: Assignment 4 *
 * Created by: Matthew Lonis *
 * Created on: October 10th, 2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: October 14th, 2016 *
 */

/* Libraries */

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

/* End of Libraries */

/* Structures */

/* Player */

typedef struct Player {
  char name[256];
  char team[256];
  double rbi;
} Player;

/* End of Player */

/* Node */

typedef struct Node {
  int num;
  struct Node *next;
} Node;

/* End of Node */

/* End of Structure */

/* Function Prototypes */

void printName(Player player);
void printRBI(Player player);

int sameTeam(Player player, char array[256]);

void printArray1D(char array[]);

int Cricket(void);

void printNode(Node * node);
int linkedList(void);

/* End of Function Prototypes */

/* main */

int main(void) {
  int choice, loop;
  loop = 1;

  printf("Welcome to Matthew Lonis' Assignment 4!\n\n");
  
  while (loop != 0) {

    printf("--- Main Menu ---\n\n");
    printf("1. Cricket\n");
    printf("2. Linked-List\n");
    printf("3. Exit\n\n");

    printf("Choice: ");
    scanf("%d", &choice);
    printf("\n");

    if (choice == 1) {
      Cricket();
    } else if (choice == 2) {
      linkedList();
    } else {
      loop = 0;
    }
  }

  return (0);
}

/* End of main */

/* Functions */

/* printName */

void printName(Player player) {
  int x = 0;

  while (player.name[x] != '\0') {
    printf("%c", player.name[x]);
    x++;
  }
}

/* End of printName */

/* printRBI */

void printRBI(Player player) {
  printf("%lf", player.rbi);
}

/* End of printRBI */

/* sameTeam */

int sameTeam(Player player, char array[]) {
  int looper = 0;
  int arrayTcount = 0;

  while(array[looper] != '\0') {
    looper++;
    arrayTcount++;
  }

  looper = 0;
  
  while ((player.team[looper] == array[looper]) && ((player.team[looper] != '\0') || (array[looper] != '\0'))) {
    looper++;
  }

  //printf("Looper = %d\n", looper);
  //printf("arrayTcount = %d\n", arrayTcount);

  if (looper == arrayTcount) {
    return 1;
  } else {
    return 0;
  }
}

/* End of sameTeam */

/* printArray1D */

void printArray1D(char array[]) {
  int i = 0;

  while (array[i] != '\0') {
    printf("%c", array[i]);
    i++;
  }
}

/* End of printArray1D */

/* Cricket */

int Cricket(void) {
  /* Getting team input */
  
  printf("Enter the number of teams you wish to record: \n");
  printf("Please note: No more than 10 teams can be created!\n\n");
  printf("Choice: ");
  int teamNum;
  scanf("%d", &teamNum);
  printf("\n");

  static char teams[10][256];
  teams[teamNum][0] = '\0';
  int word = 0;

  int count = 1;

  /* While loop: Team input */
  
  while (word < teamNum) {
    char temp[256];

    printf("Enter the name of team %d: ", count);
    scanf("%s", temp);
    
    int i = 0;
    
    while (temp[i] != '\0') {
      teams[word][i] = temp[i];
      i++;
    }
    teams[word][i] = '\0';
    count++;
    word++;
  }
  
  teams[word][0] = '\0';

  printf("Team 1 = ");
  printArray1D(teams[0]);
  printf("\n");

  printf("Team 2 = ");
  printArray1D(teams[1]);
  printf("\n");

  printf("\n");
  
  /* End of While loop: Team input */

  /* End of Team Input */

  /* Player Input */
  
  printf("Enter the TOTAL number of players for all teams: \n");
  printf("Please note: Only 20 players can be created!\n\n");
  printf("Choice: ");
  int playerNum;
  scanf("%d", &playerNum);
  printf("\n");

  int player = 0;
  static Player players[20];

  count = 1;
  
  while (player < playerNum) {
    printf("Enter the %d Player name, Team name, and batting average: ", count);
    scanf("%s %s %lf", players[player].name, players[player].team, &players[player].rbi);
    count++;
    player++;
  }

  players[player].name[0] = '\0';
  players[player].team[0] = '\0';
  players[player].rbi = 0;
  
  printf("\n");
  printf("Listing of players and batting average according to team names:\n\n");
  
  
  int i = 0;
  int teamI = 0;

  /* Printing out players */
  
  while (teamI < teamNum) {
    printArray1D(teams[teamI]);
    printf("-\n");
    while (i < playerNum) {
      printf("          ");

      if (players[i].name[0] == '\0') {
	break;
      } else if (sameTeam(players[i], teams[teamI]) == 1) {
	printName(players[i]);
	printf("     ");
	printRBI(players[i]);
	printf("\n");
	i++;
      } else {
	i++;
      }
      
    }
    i = 0;
    teamI++;
  }

  /* End of Player Printing */

  printf("\n");
  
  return (0);
}

/* End of Cricket */

/* printNode */

void printNode(Node * node) {
  static Node * print;
  print = node;

  printf("The link list currently has these nodes:\n");
  
  while (print != NULL) {
    printf("%d->", print->num);
    print = print->next;
  }
  printf("\n\n");
}

/* End of printNode */

/* linkedList */

int linkedList(void) {
  printf("This program initializes a linked list\n");
  printf("It starts out empty, so the first thing you probably want to do is insert a node.\n\n");
  printf("After that, enjoy trying the various functions.\n\n");
  printf("Please Note: This program is designed to accept integer values only.\n\n");

  int loop = 1;
  
  static Node * head;
  static Node * current;
  
  if (head == NULL) {
    printf("Head is indeed NULL my nigger friend\n\n");
  } else {
    printf("The head isn't NULL my nigger friendz\n\n");
  }
  
  while (loop != 0) {
    
    printf("Please enter your choice:\n");
    printf("1. INSERT a node at the END of the linklist\n");
    printf("2. INSERT a node at the BEGINNING of the linklist\n");
    printf("3. DELETE a node at the END of the linklist\n");
    printf("4. DELETE a node at the BEGINNING of the linklist\n");
    printf("5. INSERT a node at the MIDDLE of the linklist\n");
    printf("6. DELETE a node at the MIDDLE of the linklist\n");
    printf("7. MODIFY any node in linklist\n");
    printf("8. EXIT\n\n");
    
    printf("Choice: ");
    int choice;
    scanf("%d", &choice);
    printf("\n");
    
    if (choice == 1) {
      Node * nodeAddEnd = (Node *) malloc(sizeof(Node));
      int val;
      printf("Enter your node in the linked list: ");
      scanf("%d", &val);
      printf("\n");
      
      nodeAddEnd->num = val;
      nodeAddEnd->next = NULL;
      
      if (head == NULL) {
	head = (Node *) malloc(sizeof(Node));
	head->num = val;
	head->next = NULL;
      } else {
	current = head;
	while (current->next != NULL) {
	  current = current->next;
	}
	current->next = nodeAddEnd;
      }
      printNode(head);
    } else if (choice == 2) {
      Node * temp = (Node *) malloc(sizeof(Node));
      int val2;
      printf("Enter the value for the node you want to insert at the beginning: ");
      scanf("%d", &val2);
      printf("\n");

      temp->num = val2;
      temp->next = head;

      head = temp;
      free(temp);
      printNode(head);
    } else if (choice == 3) {
      Node * temp;
      temp = head;
      Node *t;
      while(temp->next != NULL) {
	t=temp;
	temp = temp->next;
      }
      t->next = NULL; 
      free(temp);
      printNode(head);
    } else if (choice == 4) {
      Node * temp = (Node *) malloc(sizeof(Node));
      temp = head;
      head = head->next;
      free(temp);
      
      printNode(head);
    } else if (choice == 5) {
      int val_pos;
      Node * temp = head;
      Node * temp1 = (Node *) malloc(sizeof(Node));
      Node * newNode = (Node *) malloc(sizeof(Node));
      
      printf("Enter the value of the node after which you want to insert a new node: ");
      scanf("%d", &val_pos);
      printf("\n");

      int val5;
      printf("Enter the value of the new node: ");
      scanf("%d", &val5);
      printf("\n");

      newNode->num = val5;

      while (temp->num != val_pos) {
	temp = temp->next;
      }

      temp1 = temp->next;
      temp->next = newNode;
      newNode->next = temp1;
      
      printNode(head);
    } else if (choice == 6) {
      int val_pos;
      Node * temp = head;
      Node * temp1 = (Node *) malloc(sizeof(Node));
      
      printf("Enter the value of the node that precedes the node you want to delete: ");
      scanf("%d", &val_pos);
      printf("\n");

      if (temp->num == val_pos) {
	temp1 = temp->next;
	temp->next = temp1->next;
      } else {
	while (temp->num != val_pos) {
	  temp = temp->next;
	}	
	temp1 = temp->next;
	temp->next = temp1->next;
      }
      
      printNode(head);
    } else if (choice == 7) {
      int val_pos2;
      int val7;
      Node * temp = head;
      Node * temp1 = (Node *) malloc(sizeof(Node));

      printf("Enter the value of the node you want to modify: ");
      scanf("%d", &val_pos2);
      printf("\n");

      printf("Enter the new value for this node: ");
      scanf("%d", &val7);
      printf("\n");

      if (temp->num == val_pos2) {
	temp->num = val7;
      } else {
	while (temp->num != val_pos2) {
	  temp = temp->next;
	}
	temp->num = val7;
      }
      
      printNode(head);
    } else {
      loop = 0;
    }
  }
  
  return (0);
}

/* End of linkedList */

/* End of Functions */

/* End of A4.c */
