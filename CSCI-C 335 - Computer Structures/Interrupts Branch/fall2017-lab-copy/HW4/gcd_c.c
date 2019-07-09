/* gcd_c.c --- 
 * 
 * Filename: gcd_c.c
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: 
 * Created: Tue Oct 27 12:23:21 2015
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

/* Algorithm from https://en.wikipedia.org/wiki/Greatest_common_divisor */

int gcd_c(int a, int b) {
  int d = 0;

  while (!(a & 1) && !(b & 1)) {
    a >>= 1;
    b >>= 1;
    d += 1;
  }
  while (a != b) {
    if (!(a & 1)) a >>= 1;
    else if (!(b & 1)) b >>= 1;
    else if (a > b) a = ((a-b) >> 1);
    else b = ((b-a) >> 1);
  }
  return a << d;
}

/* gcd_c.c ends here */
