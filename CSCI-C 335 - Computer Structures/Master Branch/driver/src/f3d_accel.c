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

void f3d_accel_init() {
    // Accelerometer I2C Address = 0x32
    
    uint8_t value = 0;
    
    value = 0x40|0x07;                 // Normal Power Mode, All Axis Enable (X,Y,Z)
    f3d_i2c1_write(0x32, 0x20, &value); // Accel (0x32), Ctrl Reg1 (0x20)
    
    value = 0x08;                      // Continuous Update, Little Endian, 2G Sensitivity, High Resolution Mode
    f3d_i2c1_write(0x32, 0x23, &value); // Accel (0x32, Ctrl Reg4  (0x23)
    
    
    value = 0x10 | 0x80;               // HPF Cutoff 16, High Pass Filter Normal Mode, AO1/AO1 Disable
    f3d_i2c1_write(0x32, 0x21, &value); // Accel (0x32, Ctrl Reg2  (0x21)
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

/**
 * Accelerometer app that displays a compass on the LCD. Made this in Lab 7.
 *
 * @param init  If this value = 1, the baord utils have not been initialized and need to be.
 */
int f3d_accel_app(int init) {
  if (init) {
    f3d_init(0);
  }
  
  float accel[3];
  
  nunchuk_t nunData;
  unsigned char jx;
  unsigned char c;
  unsigned char z;
  f3d_nunchuk_read(&nunData);
  jx = nunData.jx;
  c = nunData.c;
  z = nunData.z;
  
  f3d_accel_read(accel);
  
  float pitch = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 0);
  float roll = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 1);
  
  float prevPitch = pitch;
  float prevRoll = roll;
  
  f3d_lcd_fillScreen(GREEN);
  
  f3d_lcd_drawString(14, 1, "Tilt Angle Visual", BLACK, GREEN);

  delay(250);
  
  while(1) {
    if (user_btn_read()) {
      return 1;
    }

    f3d_nunchuk_read(&nunData);
    jx = nunData.jx;
    c = nunData.c;
    z = nunData.z;
    
    if (c == 1) {
      return 1;
    } else if (z == 1) {
      return -1;
    }
    
    if (jx > 200) {
      return 1;
    } else if (jx < 55) {
      return -1;
    }
    
    f3d_accel_read(accel);
    
    pitch = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 0);
    roll = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 1);
    
    if ((pitch - prevPitch) > 0.1 || (pitch - prevPitch) < -0.1 || (roll - prevRoll) > 0.1 || (roll - prevRoll) < -0.1) {

      char str[20];
      
      snprintf(str, sizeof(float) * 22, "Pitch:%5.3f radians ", pitch);
      f3d_lcd_drawString(2, 140, str, BLACK, GREEN);
      
      snprintf(str, sizeof(float) * 22, "Roll:%5.3f radians ", roll);
      f3d_lcd_drawString(2, 150, str, BLACK, GREEN);
      
      f3d_lcd_drawString(64, 80, "+", RED, GREEN);
      
      int x1 = (64 + (prevRoll * 40) - 1);
      int y1 = (80 + (prevPitch * 40) - 1);
      int x2 = (64 + (prevRoll * 40) + 4);
      int y2 = (80 + (prevPitch * 40) + 6);
      f3d_lcd_fillScreenXYXY(x1, y1, x2, y2, GREEN);
      
      f3d_lcd_drawString(64+(roll*40), 80+(pitch*40), "*", BLACK, GREEN);
      
      prevRoll = roll;
      prevPitch = pitch;
    }
  }
}

/* f3d_accel.c ends here */
