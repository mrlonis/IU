/* f3d_accel.h --- 
 * 
 * Filename: f3d_accel.h
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Oct 31 09:15:45 2013
 * Last-Updated: 19 October 2017
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

void f3d_accel_init();
void f3d_accel_read(float *);

/**
 * This function calculates the tilt angle of the board.
 *
 * @param type  Specified the type f return value:
 *              If type is 0, pitch is returned.
 *              If type is 1, roll is returned.
 */
float f3d_accel_calcTiltAngle(float x, float y, float z, int type);

/**
 * Accelerometer app that displays a compass on the LCD. Made this in Lab 7.
 *
 * @param init  If this value = 1, the baord utils have not been initialized and need to be.
 */
int f3d_accel_app(int init);

/* f3d_accel.h ends here */
