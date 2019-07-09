#include <stdio.h>
#include "student.h"
#include "operations.h"

student_t student1 = {{"Matthew",3179020228,"10922 Woodward Drive"}, {100, 100, 100, 100}};
student_t student2 = {{"Jack",3172138306,"10921 Woodward Drive"}, {100, 100, 100, 100}};
student_t student3 = {{"Joey",4154072798,"Bloomington, IN"}, {100, 100, 100, 100}};
student_t student4 = {{"Chris",3175192471,"Bloomington, IN"}, {100, 100, 100, 100}};
student_t student5 = {{"Morgen",3176287415,"Bloomington, IN"}, {100, 100, 100, 100}};

void main(void) {
  int num;
  student_t students[5];
  
  printf("Enter the number of students to be created (Note: Must be a number between 1 and 5):\n\n");
  scanf(" %d", &num);
  printf("\n");
  
  int y = 0;
  
  do {
    
    if (y == 0) {
      students[0] = student1;
    } else if (y == 1) {
      students[1] = student2;
    } else if (y == 2) {
      students[2] = student3;
    } else if (y == 3) {
      students[3] = student4;
    } else if (y == 4) {
      students[4] = student5;
    }
    
    y++;
    
  } while (y != num);

  if (num == 1) {
    printf("1 student created.\n\n");
  } else {
    printf("%d students created.\n\n", num);
  }
  
  int main_option;

  while (main_option != 4) {
  
    printf("Enter you option:\n\n");
    printf("1. Update record\n");
    printf("2. Print all student record\n");
    printf("3. Find out average of class\n");
    printf("4. Exit\n\n");
    
    scanf(" %d", &main_option);
    printf("\n");
  
    if (main_option != 4) {
    
      if (main_option == 1) {
	
	int student_num, update_option;
    
	printf("Enter student number (Must be a number between 1 and 5):\n\n");
	scanf(" %d", &student_num);
	printf("\n");
    
	printf("Enter your option: \n\n");
	printf("1. Name\n");
	printf("2. contact number\n");
	printf("3. Address\n");
	printf("4. Assignment\n");
	printf("5. Mid term\n");
	printf("6. Final\n");
	printf("7. Go back\n\n");
	
	scanf(" %d", &update_option);
	printf("\n");

	if (student_num == 1) {
	  students[0] = update_record(students[0], update_option);
	} else if (student_num == 2) {
	  students[1] = update_record(students[1], update_option);
	} else if (student_num == 3) {
	  students[2] = update_record(students[2], update_option);
	} else if (student_num == 4) {
	  students[3] = update_record(students[3], update_option);
	} else if (student_num == 5) {
	  students[4] = update_record(students[4], update_option);
	} else {
	}

      } else if (main_option == 2) {
	int i=0;
	int a=1;
	while (i != 5) {
	  print_record(students[i], a);
	  i++;
	  a++;
	}
    
      } else if (main_option == 3) {
	float average;
	average = average_class(students, num);
	printf("The class average is: %f percent.\n", average);
	
      } else {
    
	break;
    
      }
      main_option = 0; 
    }
  
  }
  
}
