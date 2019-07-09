/* test2.c --- 
 * 
 * Filename: test2.c
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: 
 * Created: Tue Oct 27 12:32:24 2015
 * Last-Updated: 11 November 2017
 *           By: Matthew Lonis
 *     Update #: 0
 * Keywords: 
 * Compatibility: 
 * 
 */

/* Commentary: 
 * 
 * 
 * 
 */

/* Change log:
 * 
 * 
 */

/* Copyright (c) 2004-2007 The Trustees of Indiana University and 
 * Indiana University Research and Technology Corporation.  
 * 
 * All rights reserved. 
 * 
 * Additional copyrights may follow 
 */

/* Code: */

#include <stdio.h>
#include <stdint.h> 
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "abs.h"
#include "gcd.h"
#include "fib.h"
#include "max_array.h"
#include "mult_by_5.h"
#include "string_length.h"
#include "reg_name.h"

void abs_test(void) {
  int error_count=0;
  int i;
  for (i=-100;i<100;i++) {
    if (abs(i)!=abs_c(i)) {    
      printf("ABS Error: Input %d, Expected %d, Received %d\n",i,abs_c(i),abs(i));
      error_count++;
    }
  }
  if (!error_count) {
    printf("ABS Tests Passed\n");
  }
  else {
    printf("ABS Test: %d errors\n",error_count);
  }
}

void gcd_test(void) {
  int error_count=0;
  uint32_t i,j;
  for (i=1;i<100;i++) {
    for (j=1;j<100;j++) {
      if (gcd(i,j)!=gcd_c(i,j)) {
        printf("GCD Error: Input (%lu,%lu), Expected %d, Received %d\n",i,j,gcd_c(i,j),gcd(i,j));
  	error_count++;
      }
    }
  }
  if (!error_count) {
    printf("GCD Tests Passed\n");
  }
  else {
    printf("GCD Test: %d errors\n",error_count);
  }
}

void fib_test(void) {
  int inc = 0;
  int error_count=0;
  int fibR, fib_cR;

  while (inc <= 46) {
    fibR = fib(inc);
    fib_cR = fib_c(inc);

    if (fibR != fib_cR) {
      printf("Fib Error: Input %d, Expected %d, Received %d\n", inc, fib_cR, fibR);
      error_count++;
    }

    inc = inc + 1;
  }

  if (!error_count) {
    printf("Fib Tests Passed\n");
  } else {
    printf("Fib Test: %d errors\n", error_count);
  }
}

void max_array_test(void) {
  int error_count = 0;
  int maxR, max_cR;
    
  unsigned int ints[5] = {1, 2, 3, 4, 5};
  unsigned int * p;
  p = ints;

  maxR = max_array(p, 5);
  max_cR = max_array_c(p, 5);

  if (maxR != max_cR) {
    printf("Max_array Error: Expected %d, Received %d\n", max_cR, maxR);
    error_count++;
  }
  

  if (!error_count) {
    printf("Max_array Tests Passed\n");
  } else {
    printf("Max_array Test: %d errors\n", error_count);
  }
}

void mult_by_5_test(void) {
  int inc = 0;
  int error_count=0;
  int maxR, max_cR;

  while (inc <= 46) {
    maxR = mult_by_5(inc);
    max_cR = mult_by_5_c(inc);

    if (maxR != max_cR) {
      printf("mult_by_5 Error: Input %d, Expected %d, Received %d\n", inc, max_cR, maxR);
      error_count++;
    }
    
    inc = inc + 1;
  }

  if (!error_count) {
    printf("mult_by_5 Tests Passed\n");
  } else {
    printf("mult_by_5 Test: %d errors\n", error_count);
  }
}

void reg_name_test(void) {
  int inc = 0;
  int error_count=0;
  char * maxR;
  char * max_cR;

  while (inc <= 15) {
    maxR = reg_name(inc);
    max_cR = reg_name_c(inc);
    
    if (strcmp(maxR, max_cR) != 0) {
      printf("reg_name Error: Input %d, Expected %s, Received %s\n", inc, max_cR, maxR);
      error_count++;
    }

    inc = inc + 1;
  }

  if (!error_count) {
    printf("reg_name Tests Passed\n");
  } else {
    printf("reg_name Test: %d errors\n", error_count);
  }
}

void string_length_test(void) {
  int error_count=0;
  int maxR, max_cR;
  char * string = "Hello";

  maxR = string_length(string);
  max_cR = string_length_c(string);

  if (maxR != max_cR) {
    printf("string_length Error: Expected %d, Received %d\n", max_cR, maxR);
      error_count++;
  }

  if (!error_count) {
    printf("string_length Tests Passed\n");
  } else {
    printf("string_length Test: %d errors\n", error_count);
  }
}

/* test_functions.c ends here */
