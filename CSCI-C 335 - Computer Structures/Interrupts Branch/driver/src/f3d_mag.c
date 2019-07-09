/* f3d_mag.c ---
 *
 * Filename: f3d_mag.c
 * Description:
 * Author: Bryce Himebaugh
 * Maintainer:
 * Created: Thu Oct 31 09:27:11 2013
 * Last-Updated: 19 October 2017
 *           By: Matthew Lonis
 *     Update #: ?
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

#include <f3d_accel.h>
#include <f3d_delay.h>
#include <f3d_gyro.h>
#include <f3d_i2c.h>
#include <f3d_init.h>
#include <f3d_lcd_sd.h>
#include <f3d_led.h>
#include <f3d_mag.h>
#include <f3d_nunchuk.h>
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <glcdfont.h>
#include <stm32f30x.h>
#include <stdio.h>
#include <math.h>

void f3d_mag_init() {
  printf("mag init...\n");
    // MAG I2C Address = 0x3C
    
    uint8_t value = 0;
    
    value = 0x14;                  //Temp sensor disable,30Hz Output Rate
    f3d_i2c1_write(0x3C, 0x00,  &value); // Mag (0x3C), CRA (0x00)
    
    value = 0xE0;                      // +/- 8.1 Gauss Full Scale
    f3d_i2c1_write(0x3C, 0x01, &value); // Mag (0x3C), CRB (0x01)
    
    value = 0x00;                      // Continuous Conversion
    f3d_i2c1_write(0x3C, 0x02, &value); // Mag (0x3C), MR  (0x23)
    printf("mag init successful...\n");
}

void f3d_mag_read(float *mag_data) {
    uint8_t buffer[6];
    int i;
    
    // Read X Axis
    f3d_i2c1_read(0x3C, 0x03, buffer,2);

    // Read Y Axis
    f3d_i2c1_read(0x3C, 0x07, buffer+2,2);

    // Read Z Axis (notice Z is out of order in the chip)
    f3d_i2c1_read(0x3C, 0x05, buffer+4,2);
    
    for (i=0; i<2; i++) {
        mag_data[i]=(float)((int16_t)(((uint16_t)buffer[2*i] << 8) + buffer[2*i+1]))/230;
    }
    mag_data[2]=(float)((int16_t)(((uint16_t)buffer[4] << 8) + buffer[5]))/205;
}

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
float f3d_mag_calcCompassHeading(float pitch, float roll, float xM, float yM, float zM, int type) {
    float xH = (xM * cos(pitch)) + (zM * sin(pitch));
    float yH = (xM * sin(pitch) * sin(roll)) + (yM * cos(roll)) - (zM * sin(roll) * cos(pitch));
    
    float heading;
    
    if (type) {
      heading = atanf(yH/xH);
    } else {
      heading = ( atanf(yH/xH) * (180 / M_PI) );
    }
    
    return heading;
}

/* f3d_mag.c ends here */
