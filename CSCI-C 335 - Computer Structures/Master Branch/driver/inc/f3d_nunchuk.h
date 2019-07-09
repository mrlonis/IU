/* f3d_nunchuk.h --- 
 * 
 * Filename: f3d_nunchuk.h
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Oct 31 09:41:40 2013
 * Last-Updated: 20 October 2017
 *           By: Matthew Lonis
 *     Update #: 1
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
 * 5 October 2017:
 *  - Header Changes
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
#include <stm32f30x.h>

typedef struct nunchuk_data { 
  unsigned char jx;
  unsigned char jy;
  unsigned short ax;
  unsigned short ay;
  unsigned short az;
  unsigned char c;
  unsigned char z;
} nunchuk_t; 

void f3d_nunchuk_init(void);
void f3d_nunchuk_read(nunchuk_t *);

float f3d_nunchuk_calcTiltAngle(float x, float y, float z, int type);
int f3d_nunchuk_app(int init);

/* f3d_nunchuk.h ends here */
