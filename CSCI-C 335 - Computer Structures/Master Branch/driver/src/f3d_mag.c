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

int arrow[31][2] = { {64, 65}, {64, 66}, {64, 67}, {64, 68}, {64, 69}, {64, 70}, {64, 71}, {64, 72}, {64, 73}, {64, 74}, {64, 75}, {64, 76}, {64, 77}, {64, 78}, {64, 79}, {64, 80}, {64, 81}, {64, 82}, {64, 83}, {64, 84}, {64, 85},  {64, 86}, {64, 87}, {64, 88}, {64, 89}, {64, 90}, {64, 91}, {64, 92}, {64, 93}, {64, 94}, {64, 95} };

void f3d_mag_init() {
    // MAG I2C Address = 0x3C
    
    uint8_t value = 0;
    
    value = 0x14;                  //Temp sensor disable,30Hz Output Rate
    f3d_i2c1_write(0x3C, 0x00,  &value); // Mag (0x3C), CRA (0x00)
    
    value = 0xE0;                      // +/- 8.1 Gauss Full Scale
    f3d_i2c1_write(0x3C, 0x01, &value); // Mag (0x3C), CRB (0x01)
    
    value = 0x00;                      // Continuous Conversion
    f3d_i2c1_write(0x3C, 0x02, &value); // Mag (0x3C), MR  (0x23)
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

/**
 * Magnetometer app that displays a compass on the LCD. Made this in Lab 7.
 *
 * @param init  If this value = 1, the baord utils have not been initialized and need to be.
 */
int f3d_mag_app(int init) {
    if (init) {
        f3d_init(0);
    }
    
  f3d_lcd_fillScreen(WHITE);

  f3d_lcd_drawString(18, 1, "Compass Heading", BLACK, WHITE);

  float accel[3];
  float mag[3];
  
  int r = 25;
  
  int xO = 64;
  int yO = 80;

  int x;
  int y;
  int i;
  
  nunchuk_t nunData;
  unsigned char jx;
  unsigned char c;
  unsigned char z;
  f3d_nunchuk_read(&nunData);
  jx = nunData.jx;
  c = nunData.c;
  z = nunData.z;
  
  f3d_accel_read(accel);
  f3d_mag_read(mag);
  
  float pitch = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 0);
  float roll = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 1);
  float yaw = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 2);
  float headingRadian = f3d_mag_calcCompassHeading(pitch, roll, mag[0], mag[1], mag[2], 1);
  float headingDegree = f3d_mag_calcCompassHeading(pitch, roll, mag[0], mag[1], mag[2], 0);
  float prevHeadingDegree = headingDegree;

  for (i = 0; i < 360; i++) {
    x = (r * cos(i)) + xO;
    y = (r * sin(i)) + yO;
    f3d_lcd_drawPixel(x, y, BLACK);
  }

  int coords[8] = { 64, 40, 62, 115, 20, 75, 105, 76 };

  f3d_lcd_drawString(coords[0], coords[1], "N", BLACK, WHITE);
  f3d_lcd_drawString(coords[2], coords[3], "S", BLACK, WHITE);
  f3d_lcd_drawString(coords[4], coords[5], "E", BLACK, WHITE);
  f3d_lcd_drawString(coords[6], coords[7], "W", BLACK, WHITE);

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
    
    if ( (headingDegree - prevHeadingDegree) > 5 ||  (headingDegree - prevHeadingDegree) < -5) {
      
      f3d_lcd_fillScreenXYXY(10, 30, ST7735_width - 11, ST7735_height - 31, WHITE);
      float rotation = headingRadian + (2 * M_PI);
      
      r = 25;
      
      for (i = 0; i < 360; i++) {
	x = (r * cos(i)) + xO;
	y = (r * sin(i)) + yO;
	f3d_lcd_drawPixel(x, y, BLACK);
      }
      
      r = 35;
      
      x = (r * cos(rotation)) + xO;
      y = (r * sin(rotation)) + yO;
      f3d_lcd_drawString(x, y, "N", BLACK, WHITE);
      
      rotation += M_PI;
      
      x = (r * cos(rotation)) + xO;
      y = (r * sin(rotation)) + yO;
      f3d_lcd_drawString(x, y, "S", BLACK, WHITE);
      
      rotation -= (M_PI / 2);
      
      x = (r * cos(rotation)) + xO;
      y = (r * sin(rotation)) + yO;
      f3d_lcd_drawString(x, y, "E", BLACK, WHITE);
      
      rotation += M_PI;
      
      x = (r * cos(rotation)) + xO;
      y = (r * sin(rotation)) + yO;
      f3d_lcd_drawString(x, y, "W", BLACK, WHITE);
    }
    
    f3d_accel_read(accel);
    f3d_mag_read(mag);
    
    pitch = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 0);
    roll = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 1);
    yaw = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 2);
    headingRadian = f3d_mag_calcCompassHeading(pitch, roll, mag[0], mag[1], mag[2], 1);
    prevHeadingDegree = headingDegree;
    headingDegree = f3d_mag_calcCompassHeading(pitch, roll, mag[0], mag[1], mag[2], 0);
  }
}


/* f3d_mag.c ends here */
