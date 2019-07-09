#include <stdio.h>
#include <string.h>
#include "student.h"

student_t update_record (student_t student, int update_option) {
  if (update_option == 1) {
    char name;
    printf("Enter student name: \n\n");
    scanf(" %[^\n]s", student.personal_details.name);
    printf("\n");
    return student;
  } else if (update_option == 2) {
    long contact_number;
    printf("Enter student contact number: \n\n");
    scanf(" %ld", &contact_number);
    printf("\n");
    student.personal_details.contact_no = contact_number;
    return student;
  } else if (update_option == 3) {
    char address;
    printf("Enter student address: \n\n");
    scanf(" %[^\n]s", student.personal_details.address);
    printf("\n");
    return student;
  } else if (update_option == 4) {
    int assignment;
    printf("Enter student aissgnment number: \n\n");
    scanf(" %d", &assignment);
    printf("\n");
    student.university_record.assignment = assignment;
    return student;
  } else if (update_option == 5) {
    int mid_term;
    printf("Enter student mid term number: \n\n");
    scanf(" %d", &mid_term);
    printf("\n");
    student.university_record.mid_term = mid_term;
    return student;
  } else if (update_option == 6) {
    int final;
    printf("Enter student final mark: \n\n");
    scanf(" %d", &final);
    printf("\n");
    student.university_record.final_mark = final;
    return student;
  } else {
    return student;
  }

}

void print_record(student_t student, int a) {
  printf("Student %d\n\nPersonal Information:\n%s: %ld - %s\n\nUniversity Record:\n%d %d %d %d\n\n", a, student.personal_details.name, student.personal_details.contact_no, student.personal_details.address, student.university_record.assignment, student.university_record.mid_term, student.university_record.final_mark, student.university_record.total);
}

int average_class (student_t students[5], int num) {
  int i;
  float total, average;

  for(i=0; i != num; i++) {
    student_t x = students[i];
    total += x.university_record.final_mark;
  }

  average = total / i;
  return average;
}
