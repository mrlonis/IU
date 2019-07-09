/* main.c */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include "names.h"


int main(int argc, char *argv[]) {
  int i, items_returned, status;
  FILE * infile;
  FILE * outfile;
  name_t * imported_list;

  if (argc!=3) {
    printf("Error - Incorrect number of arguments\n");
    exit(EXIT_FAILURE);
  }
  infile = fopen(argv[1],"r");
  status = errno;
  if (!infile) {
    if (status==ENOENT) {
      printf("File does not exist\n");
    }
    else {
      printf("Error Number %d\n",errno);
    }
    exit(EXIT_FAILURE);
  }
  else {
    if (imported_list = import_name_list (infile)) {
      // List imported successfully
      outfile = fopen(argv[2],"w+");
      status = errno;
      if (outfile) {
	// Write the output file
	export_list(outfile,imported_list);
	fclose(outfile);
      }
      else {
	printf("Error opening outfile, errno=%d\n",status);
      }
    }
    else {
      printf("Error importing list\n");
      fclose(infile);
      exit(EXIT_FAILURE);
    }
  }
  exit(EXIT_SUCCESS);
}



/* main.c ends here */
