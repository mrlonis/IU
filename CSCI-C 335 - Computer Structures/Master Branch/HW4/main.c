/* main.c --- 
 * 
 * Filename: main.c
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: 
 * Created: Tue Oct 27 12:16:39 2015
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
#include "test_functions.h"

int main(void){
  abs_test(); // Both C and assembly pass
  gcd_test(); // Both C and Assembly pass
  fib_test(); // Assembly doesn't work
  mult_by_5_test(); // C Passes - Haven't tested assembly
  reg_name_test(); // C Passes - Haven't tested assembly
  max_array_test(); // C Wroks - Haven't tested assembly
  string_length_test(); // C works - Haven't tested with assembly
  return 0;
} 

/* main.c ends here */
