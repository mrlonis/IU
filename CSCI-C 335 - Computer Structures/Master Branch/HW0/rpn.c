/**
 * rpn.c
 *
 * Created On: 08/29/2017
 * Created By: Matthew Lonis
 * Last Modified On: 09/03/2017
 * Last Modified By: Matthew Lonis
 *
 * Part Of/Assignment: HW 0
 */

/*
 * Library imports needed for this program
 */
#include <stdio.h>
#include <stdlib.h>

/*
 * Cell typedef instructions
 */
typedef struct CELL *LIST;

struct CELL {
  int val;
  LIST next;
};

/*
 * Global variables. These allow functions to all access the same data 
 * without having to pass around references
 */
static LIST stack;
static int start;
static int end;
/*
 * 1,000 was a randomly selected number. I figured anyone using my 
 * program wouldn't need more than 1,000 chars. In modern day programs, 
 * designed for a desktop or laptop hardware, the production of a 
 * static array of 1,000 chars is fairly minimal in terms of space used.
 */
static char input [1000];

/*
 * This popPrint function works just like the pop function seen below
 * except it doesn't actually remove the top element from the stack. 
 * This allows for quick printing of the top element without changing 
 * the list.
 */
void popPrint() {
  if (stack == NULL) {
    printf("rpn: stack empty");
  } else {
    printf("%d\n", stack->val);
  }
}

/*
 * The stackToString function prints out entire contents of the 
 * stack putting each element on a newline
 */
void stackToString() {
  if (stack != NULL) {
    LIST c = stack;

    while (c != NULL) {
      printf("%d\n", c->val);
      c = c->next;
    }
  } else {
    printf("rpn: stack empty\n");
  }
}

/*
 * This push function "pushes" the given 'val' onto the top of 
 * the stack, making it the first element in the list.
 *
 * @param  val  The integer value to be added to the stack
 */
void push(int val) {
  LIST c = (LIST) malloc(sizeof(struct CELL));
  if (c) {
    c->val = val;
    c->next = stack;
    stack = c;
  } else {
    printf("rpn: insufficient memory\n");
  }
}

/*
 * The pop function pops the first, or top, element off of the stack
 * and returns the value. This function ultimately changes the stack,
 * by removing the first element.
 *
 * val is initially set to 2147483647 instead of any other number. My 
 * reasoning for this is simple. This function HAS to return something, 
 * right? But what happens if the stack is NULL? I can't just simply 
 * return 0 as that is a fairly common int. Later on in my add(), 
 * subtract(), multiply() and divide() functions, I use the fact that 
 * if the stack is NULL, 2147483647 is returned to do error checking. 
 * It seems highly improbable to me that a user would ever input 
 * 2147483647, so if pop returns 2147483647, I know this is out of error.
 *
 * @return  The top element in the stack that was popped off of the top.
 */
int pop() {
  int val = 2147483647;

  if (stack == NULL) {
    printf("rpn: stack empty");
  } else {
    val = stack->val;
    stack = stack->next;
  }

  return val;
}

/*
 * The add function takes the top two elements off of the stack, 
 * adds them, and then pushes the resulting number onto the stack.
 */
void add() {
  if (stack == NULL) {
    printf("rpn: stack empty\n");
  } else if (stack->next == NULL) {
    printf("rpn: not enough numbers in the stack to perform operation\n");
  } else {
    int number1 = pop();
    int number2 = pop();
      
    if (number1 == 2147483647 || number2 == 2147483647) {
      printf("rpn: integer data error. pop() returned max integer value\n");
    } else {
      int result = number2 + number1;

      push(result);
    }
  }
}

/*
 * The subtract function takes the top two elements off of the stack, 
 * subtracts the first number from the second number, and then pushes 
 * the resulting number onto the stack.
 */
void subtract() {
  if (stack == NULL) {
    printf("rpn: stack empty\n");
  } else if (stack->next == NULL) {
    printf("rpn: not enough numbers in the stack to perform operation\n");
  } else {
    int number1 = pop();
    int number2 = pop();
      
    if (number1 == 2147483647 || number2 == 2147483647) {
      printf("rpn: integer data error. pop() returned max integer value\n");
    } else {
      int result = number2 - number1;
          
      push(result);
    }
  }
}

/*
 * The multiply function takes the top two elements off of the stack, 
 * multiplies them, and then pushes the resulting number onto the stack.
 */
void multiply() {
  if (stack == NULL) {
    printf("rpn: stack empty\n");
  } else if (stack->next == NULL) {
    printf("rpn: not enough numbers in the stack to perform operation\n");
  } else {
    int number1 = pop();
    int number2 = pop();
      
    if (number1 == 2147483647 || number2 == 2147483647) {
      printf("rpn: integer data error. pop() returned max integer value\n");
    } else {
      int result = number2 * number1;
          
      push(result);
    }
  }
}

/*
 * The divide function takes the top two elements off of the stack, 
 * divides the second number by the first number, and then pushes 
 * the resulting number onto the stack.
 */
void divide() {
  if (stack == NULL) {
    printf("rpn: stack empty\n");
  } else if (stack->next == NULL) {
    printf("rpn: not enough numbers in the stack to perform operation\n");
  } else {
    int number1 = pop();
    int number2 = pop();
      
    if (number1 == 2147483647 || number2 == 2147483647) {
      printf("rpn: integer data error. pop() returned max integer value\n");
    } else {
      int result = number2 / number1;
          
      push(result);
    }
  }
}

/*
 * The numberIdentifier function converts the number found between 
 * the static variables 'start' and 'end' in the 'input'[] static array.
 * It essentially parses the characters between index [start] and 
 * [end] and parses the characters into an integer.
 *
 * My reasoning for using something like this over atoi is explained in 
 * report.txt
 */
void numberIdentifier() {
  /*
   * Start off by comparing start and end. If they are equal, there 
   * is nothing to process and the program will exit early to save 
   * computation...
   */
  if (start < end) {
    /*
     * Local variables needed for the function.
     */
    int acceptAnswer = 0;
    int z = start;
    int ans = 0;
    int range = end - start;

    /*
     * This while loop translates the character at input[z] into an int. 
     * It then uses the range variable to determine the digit location of 
     * the character. 
     * 
     * So for example if '1', '2', and '3' all exist in an 
     * array of chars, the number is 123, but when you read the char '1', 
     * you translate it into an int and get '1'. We need this to be '100' 
     * however to get it into the hundreds place. This while loop loops and 
     * multiplies powerFinal by power until it gets to the right digit location.
     * It then multiplies the powerFinal by the translated int and adds it 
     * to ans. After this is done for all chars in the array, ans will equal 123
     */
    while (z < end) {
        /*
         * Power calculation
         */
        int power = 10;
        int powerFinal = 1;
        int powerCount = 1;
      
        while (powerCount < range) {
            powerFinal = powerFinal * power;
            powerCount++;
        }
      
        char c = input[z];
        int number = c - '0';
        int charNumber = (int) c;
        
      if (charNumber < 48 || charNumber > 57) {
          break;
      }
      
      number = number * powerFinal;
      ans += number;
      acceptAnswer = 1; // This is only set to 1 if ans is being modified.
      z++;
      range--;
    }

      /*
       * Because if acceptAnswer isn't 1 (meaning the program broke early 
       * because a non digit was detected, it isn't added to the list
       */
    if (acceptAnswer == 1) {
      push(ans);
    }
  }
}

/*
 * This is the Main function. This function handles receiving user input 
 * and storing the information in the global array index[].
 */
int main(int argc, char * argv []) {
    int ch, lastch = '\0';
    int i = 0;
    start = 0;
    end = 0;
    stack = NULL;
  
  printf("rpn\n");
    
  printf("\nAvailable Commands:\n\t- p: Prints the top element and leaves the stack unchanged\n");
  printf("\t- f: Prints the entire contents of the stack, top to bottom,\n\t     with each entry on a separate line, and leaves the stack\n\t     unchanged.\n");
  printf("\t- c: Clears the stack completely\n");
  printf("\t- q: Quits the program\n\t- EOF: Quits the program\n\n");
  
  for (i = 0; (ch = getchar()) != EOF; i++) {
    char c = (char) ch;
    
    input[i] = c;
    
    if (c == ' ' || c == '\n' || c == '\0') {
      numberIdentifier();
      start = end + 1;
    }  else if (c == 'q') {
      return 1;
    } else if (c == 'p') {
      popPrint();
    } else if (c == 'c') {
      stack = NULL;
    } else if (c == 'f') {
      stackToString();
    } else if (c == '+' || c == '-' || c == '*' || c == '/') {
      /*
       * This else case handles mathematical operators.
       */
      if (c == '+') {
          add();
      } else if (c == '-') {
          subtract();
      } else if (c == '*') {
          multiply();
      } else if (c == '/') {
          divide();
      }
    } else if (ch < 48 || ch > 57) {
      /*
       * This else case detects if the char is anything but char 
       * '0' - '9' and if so, treats it like a space and ignores 
       * the character, but still gets the numbers that were before 
       * it. This allows for any int (or at least as much as I've 
       * tested) to be valid.
       *
       * This comes after everything, because if it came before anything, 
       * the conditional coould be true and not process keyboard commands 
       * like 'p' or 'f'.
       */
      numberIdentifier();
      start = end + 1;
    }
    
    end++;
  }  
    
  return (0);
}
