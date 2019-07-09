#include<stdio.h>
#include<stdlib.h>

int main(int argc, char *argv[]){
  char a, b; /*Will keep track of positive integers in the array*/
  char nega,negb; /*Will keep track of negative integers in the array. Will hold the positive number only but the name helps signify that this is holding a negative value for my reference*/
  int i = 1; /*Count for my do...while loop. Initialized at 1 to avoid the program name as the [0] spot*/

  do {
    if(*argv[i] == 45){ /*Check if the starting element is '-' (decimal value 45) to know if this is a negative number. If it is a negative number we have to approach it differently*/
      if((argv[i][1] > nega) && (nega > negb)){
	negb = argv[i][1];
      } else if((argv[i][1] > negb) && (negb > nega)){
	nega = argv[i][1];
      } else if(argv[i][1] > nega){
	nega = argv[i][1];
      } else if(argv[i][1] > negb){
	negb = argv[i][1];
      } else {
      }
    } else if(*argv[i] != 0){ /*Check if the element is the null item, if it isn't, then we proceed a certain way.*/
       if((*argv[i] > a) && (a > b)){
	b = *argv[i];
      } else if((*argv[i] > b) && (b > a)){
	a = *argv[i];
      } else if(*argv[i] > a){
	a = *argv[i];
      } else if(*argv[i] > b){
	b = *argv[i];
      } else {
       }
    } else{
    }
    i++;
  } while(i < argc);

  char pos_pro, neg_pro; /*Sums up the character values. These will be used in the if statement below to display the result to the user*/
  pos_pro = a+b;
  neg_pro = nega+negb;

  if(pos_pro >= neg_pro){
    printf("The values with the highest product are: %c %c\n", a, b);
  } else {
    printf("The values with the highest product are: -%c -%c\n", nega, negb);
  }
  
}
