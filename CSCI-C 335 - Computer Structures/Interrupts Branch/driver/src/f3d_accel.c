/* f3d_accel.c ---
 *
 * Filename: f3d_accel.c
 * Description:
 * Author: Bryce Himebaugh
 * Maintainer:
 * Created: Thu Oct 31 09:14:43 2013
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

#include <stm32f30x.h>
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
#include <stdio.h>
#include <math.h>

void f3d_accel_init() {
  printf("Accel init...\n");
    // Accelerometer I2C Address = 0x32
    uint8_t value = 0;
    
    value = 0x40|0x07; // Normal Power Mode, All Axis Enable (X,Y,Z)
    f3d_i2c1_write(0x32, 0x20, &value); // Accel (0x32), Ctrl Reg1 (0x20)
    
    value = 0x08; // Continuous Update, Little Endian, 2G Sensitivity, High Resolution Mode
    f3d_i2c1_write(0x32, 0x23, &value); // Accel (0x32, Ctrl Reg4  (0x23)
    
    value = 0x10 | 0x80; // HPF Cutoff 16, High Pass Filter Normal Mode, AO1/AO1 Disable
    f3d_i2c1_write(0x32, 0x21, &value); // Accel (0x32, Ctrl Reg2  (0x21)
    printf("Accel init successful...\n");
}

void f3d_accel_read(float *accel_data) {
    int16_t raw_data[3];
    uint8_t buffer[6];
    int i;
    
    f3d_i2c1_read(0x32, 0x28, buffer, 6); // Read 6 bytes starting from accel (0x32), starting at register 0x28.
    for (i=0; i<3; i++) {
        raw_data[i]=((int16_t)((uint16_t)buffer[2*i+1] << 8) + buffer[2*i])/(uint8_t)16;
        accel_data[i]=(float)raw_data[i]/1000.0;
    }
}

/**
 * This function calculates the tilt angle of the board.
 *
 * @param type  Specified the type f return value:
 *              If type is 0, pitch is returned.
 *              If type is 1, roll is returned.
 */
float f3d_accel_calcTiltAngle(float x, float y, float z, int type) {
    if (type) {
        return atan(y/sqrt(pow(x, 2) + pow(z, 2)) );
    } else {
        return atan(x/sqrt(pow(y, 2) + pow(z, 2)) );
    }
}

/* f3d_accel.c ends here */
