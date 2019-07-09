/* fib_c.c --- 
 * 
 * Filename: fib_c.c
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: 
 * Created: Tue Oct 27 12:28:05 2015
 * Last-Updated: 
 *           By: 
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

int fib_c(int num) {
  int prev2=1;
  int prev1=1; 
  int val=1;
  int i; 
  if (num==0) return 0;
  else if (num==1) return 1;
  else {
    for (i=0;i<(num-2);i++) {
      val = prev1 + prev2;
      prev2 = prev1;
      prev1 = val;
    }
    return (val);
  }
}

/* fib_c.c ends here */
