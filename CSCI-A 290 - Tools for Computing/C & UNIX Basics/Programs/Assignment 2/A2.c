/* Filename: A2.c *
 * Part of: Assignment 2 *
 * Created by: Matthew Lonis *
 * Created on: 09/21/2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: 09/21/2016 *
 */

#include <stdio.h>

/* arrays */

void arrays() {
  
  /* Initial Variable */
  
  int size;
  
  /* User input for the size of the array */
  
  printf("Enter the size of the arrays: \n");
  printf("Size of the arrays: ");
  scanf("%d", &size);
  printf("\n");
  
  /* Array variables declaration */
  
  int array1[size], array2[size];
  int i = 0;

  /* User inputs elements for first array */

  printf("Enter the elements for the first array: \n");
  /* Used a while loop to account for the variable sized naure of the array */
  while (i < size && scanf("%d", &array1[i]) == 1) {
    i++;
  }
  printf("\n");

  i = 0;

  /* User inputs elements for the second array */

  printf("Enter the elements for the second array: \n");
  /* Used a while loop for the same reasoning as above */
  while ( i < size && scanf("%d", &array2[i]) == 1) {
    i++;
  }
  printf("\n");

  /* New variables */

  i = 0;
  int x = 0;
  int copy = 0;

  /* Intersection of two arrays */

  printf("The intersection of two arrays is: ");
  /* This while loop increments the cell in array1 */
  while (i < size) {
    /* This while loop increments the cell in array2 to compare all the cells in array2 against the 1 value from array1 */
    while (x < size) {
      /* If statement checks if the unit in the cell of array1 is the same as array2, if it is print the that value, otherwise nothing is done */
      if(array1[i] == array2[x]) {
	printf("%d", array1[i]);
      } else {
      }
      /* End of if statement */
      x++;
    }
    /* End of second while loop */
    i++;
    x = 0;
  }
  /* End of first while loop */

  printf("\n");
  
  i = 0;
  x = 0;

  /* Union of two arrays */

  printf("The union of two arrays is: ");
  /* This while loop prints array1 since all the elements in array1 are in the union regardless of the items in array2 */
  while (i < size) {
    printf("%d", array1[i]);
    i++;
  }

  i = 0;

  /* Beginning of first while loop */
  while (i < size) {    
    /* Beginning of second while loop */
    while (x < size) {
      /* If processing */
      if (array2[i] == array1[x]) {
	copy = 1;
      } else {
      }
      /* End of if processing */
      x++;
    }
    /* End of second while loop*/
    /* More if processing */
    if (copy == 1) {
      /* If copy equals one that means the ith element in array2 is found in array1 and need not be printed */
    } else {
      printf("%d", array2[i]);
    }
    /* End of if processing */
    i++;
    x = 0;
    copy = 0;
  }
  /* End of first while loop */

  printf("\n\n");

}

/* End of arrays */

/* matrices */

void matrices(int array1[][5], int array2[][4]) {
  /* Initial variable */

  int x, y, z, size_x_1, size_y_1, size_x_2, size_y_2;
  x = 0;
  y = 0;
  z = 0;
  size_x_1 = 5;
  size_y_1 = 4;
  size_x_2 = size_y_1;
  size_y_2 = size_x_1;

  /* Printing out the first matrix */

  printf("The original matrix was:\n");
  /* First while loop increments the what array inside of array1 we are in */
  while (y < size_y_1) {
    /* The second while loop prints all the elements in the xth sub-array in array1 */
    while (x < size_x_1) {
      printf("%d ", array1[y][x]);
      x++;
    }
    printf("\n");
    y++;
    x = 0;
  }
  y = 0;
  printf("\n");

  /* Transposed matrix */

  printf("The transposed matrix was:\n");
  /* first while loop increments what sub-array we are talking about */
  while (y < size_y_1) {
    /* Second while loop increments what cell in the xth sub-array we are refering to and makes array2 hold that value */
    while (x < size_x_1) {
      array2[x][y] = array1[y][x];
      x++;
    }
    /* End of second while loop */
    y++;
    x = 0;
  }
  /* End of first while loop */
  y = 0;
  
  /* This prints the now transposed matrix */

  while (y < size_y_2) {
    while (x < size_x_2) {
      printf("%d ", array2[y][x]);
      x++;
    }
    printf("\n");
    x = 0;
    y++;
  }
  printf("\n");
}

/* End of matrices */

/* calculator */

void calculator() {
  /* Initial variables */
  double number, accumulator = 0;
  char operator;
  int i = 1;
  
  printf("Begin calculations\n\n");

  /* This while loop is necessary to ensure the user's first move is setting the value of the accumulator and nothing else */
  
  while (i != 0) {
  
    /* Instructions */
    
    printf("Initialize your Accumulator with data of the form:\n");
    printf("\"number\" \"S\" which sets the Accumulator to the value of your number\n\n");
    
    /* Taking first input */
    
    scanf("%lf %c", &number, &operator);
    printf("\n");
    
    /* Accumulator equals first input */
    
    if (operator == 'S') {
      accumulator = number;
      i = 0;
    } else {
      printf("Invalid operator was given. Try again.\n\n");
    }
  }

  /* End of while loop */

  printf("Value in the Accumulator = ");
  printf("%lf\n\n", accumulator);
  
  /* More instructions */
  
  printf("Now that your first number is set, follow the same \"number\" \"operator\" format as before only this time instead of \"S\" you can use +, -, *, /, and E (where E is to end calculations)\n\n");

  /* This while loop keeps the calculator alive until the user ends the calculations */

  i = 1;
  
  while (i != 0) {
    printf("Calculation command: ");
    scanf("%lf %c", &number, &operator);
    printf("\n");

    if (operator == 'E') {
      i = 0;
    } else if (operator == '+') {
      accumulator += number;
    } else if (operator == '-') {
      accumulator -= number;
    } else if (operator == '*') {
      accumulator = accumulator * number;
    } else if ((operator == '/') && (number != 0)) {
      accumulator = accumulator / number;
    } else if ((operator == '/') && (number == 0)) {
      printf("Cannot divide by 0\n\n");
    } else if (operator == 'S') {
      accumulator = number;
    } else {
      printf("Invalid operator. Try again.\n");
      printf("Remember, only +, -, *, /, 'S', and 'E' will be accepted as valid operands\n");
    }
    printf("Value in the Accumulator = ");
    printf("%lf\n\n", accumulator);
  }
  /* End of while loop */
  printf("End of Calculations\n\n");
}

/* End of calculator */

/* main */

int main() {
  /* Initial variables */
  int loop, choice;
  loop = 1;

  /* While loop acts as a persistent menu */
  
  while (loop != 0) {
    /* Menu */
    printf("What function would you like me to run?\n\n");
    printf("     1. Arrays\n");
    printf("     2. Matrices\n");
    printf("     3. Calculator\n");
    printf("     4. Exit\n\n");

    printf("Choice: ");
    scanf("%d", &choice);
    printf("\n");

    /* Array initialization and declaration for passing to the matrices function */
    
    int array2[5][4];
    int array1[4][5] = {{1, 2, 3, 4, 5},
			{6, 7, 8, 9, 10},
			{10, 9, 8, 7, 6},
			{5, 4, 3, 2, 1}};

    /* If choice tree */
    
    if (choice == 1) {
      arrays();
    } else if (choice == 2) {
      matrices(array1, array2);
    } else if (choice == 3) {
      calculator();
    } else {
      loop = 0;
    }
    /* End of if tree */
  }
  /* End of while loop */
  printf("Goodbye!\n\n");
  return (0);
}

/* End of main */

/* End of A2.c */
