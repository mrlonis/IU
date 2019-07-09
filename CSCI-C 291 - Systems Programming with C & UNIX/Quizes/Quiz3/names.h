/* names.h */

struct name {
  char lname[30];
  char fname[30];
  char phone_number[15];
  char note[100];
  struct name * next;
};

typedef struct name name_t;

name_t * import_name_list (FILE * fp);
void print_list (name_t * list);
void export_list(FILE *, name_t *);

/* Code: */

/* names.h ends here */
