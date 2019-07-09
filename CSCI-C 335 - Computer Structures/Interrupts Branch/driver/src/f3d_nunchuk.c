/* f3d_nunchuk.c ---
 *
 * Filename: f3d_nunchuk.c
 * Description:
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Oct 31 09:40:37 2013
 * Last-Updated: 20 October 2017
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

#include <stm32f30x.h>
#include <f3d_nunchuk.h>
#include <stdio.h>
#include <math.h>

#define NUNCHUK_ADDRESS 0xA4

void f3d_nunchuk_init(void) {
  printf("Begin nunchuk init...\n");
  uint8_t realb = 0x00;
  uint8_t buf = 0x55;
  uint8_t buf2 = 0x00;
  
  // Use for factory Wii Nunchuk controllers
  //f3d_i2c1_write(NUNCHUK_ADDRESS,0x40,&realb);
  
  // Use for 3 party nunchuks like we have in the lab
  f3d_i2c1_write(NUNCHUK_ADDRESS, 0xf0, &buf);
  f3d_i2c1_write(NUNCHUK_ADDRESS, 0xfb, &buf2);
  printf("Nunchuk init successful...\n");
}

void f3d_nunchuk_read(nunchuk_t *n) {
    uint8_t data[6] = {0,0,0,0,0,0};
    int i;
    unsigned short tmp;
    
    f3d_i2c1_read_nunchuk(0xA5, data, 6);
    n->jx = data[0];
    n->jy = data[1];
    
    tmp = data[2];
    tmp = tmp << 2;
    n->ax = tmp | ((data[5] & 0x0C) >> 2);
    
    tmp = data[3];
    tmp = tmp << 2;
    n->ay = tmp | ((data[5] & 0x30) >> 4);
    
    tmp = data[4];
    tmp = tmp << 2;
    n->az = tmp | ((data[5] & 0xC0) >> 6);
    
    switch (data[5] & 0x03) {
        case 2:
            n->z = 1;
            n->c = 0;
            break;
        case 1:
            n->z = 0;
            n->c = 1;
            break;
        case 0:
            n->z = 1;
            n->c = 1;
            break;
        case 3:
            n->z = 0;
            n->c = 0;
            break;
    }
}

/**
 * This function calculates the tilt angle of the nunchuk.
 *
 * @param type  Specified the type f return value:
 *              If type is 0, pitch is returned.
 *              If type is 1, roll is returned.
 */
float f3d_nunchuk_calcTiltAngle(float x, float y, float z, int type) {
    if (type) {
        return atan(y/sqrt(pow(x, 2) + pow(z, 2)) );
    } else {
        return atan(x/sqrt(pow(y, 2) + pow(z, 2)) );
    }
}

/* f3d_nunchuk.c ends here */
