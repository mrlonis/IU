/* f3d_mag.h --- 
 *
 * Filename: f3d_mag.h
 * Description:
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Oct 31 09:29:25 2013
 * Last-Updated: 5 October 2017
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

void f3d_mag_init();
void f3d_mag_read(float *);

/**
 * This function calculates the compass heading. This includes tilt correction.
 *
 * @param pitch     The pitch of the board
 * @param roll      The roll of the board
 * @param xM        The x-axis data from the magnetometer
 * @param yM        The y-axis data from the magnetometer
 * @param zM        The z-axis data from the magnetometer
 * @param type      Specifies return value. If type = 0, degrees value is returned.
 *                  If type = 0, radians value is returned.
 */
float f3d_mag_calcCompassHeading(float pitch, float roll, float xM, float yM, float zM, int type);

/**
 * Magnetometer app that displays a compass on the LCD. Made this in Lab 7.
 *
 * @param init  If this value = 1, the baord utils have not been initialized and need to be.
 */
int f3d_mag_app(int init);

/* f3d_mag.h ends here */
