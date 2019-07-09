typedef struct personal_details {
  char name[25];
  long contact_no;
  char address[50];
} personal_details_t;

typedef struct university_record {
  int assignment;
  int mid_term;
  int final_mark;
  int total;
} university_record_t;

typedef struct student {
  personal_details_t personal_details;
  university_record_t university_record;
} student_t;
