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

int f3d_nunchuk_app(int init) {
    if (init) {
        f3d_init(0);
    }
    
    unsigned char jx;
    unsigned char jy;
    int ax;
    float axF;
    int ay;
    float ayF;
    int az;
    float azF;
    unsigned char c;
    unsigned char z;
    
    nunchuk_t nunData;
    
    f3d_nunchuk_read(&nunData);

    jx = nunData.jx;
    jy = nunData.jy;
    ax = nunData.ax - 500;
    axF = (float) (ax / 1000.0);
    ay = nunData.ay - 500;
    ayF = (float) (ay / 1000.0);
    az = nunData.az - 500;
    azF = (float) (az / 1000.0);
    c = nunData.c;
    z = nunData.z;
    
    float pitch = f3d_accel_calcTiltAngle(axF, ayF, azF, 0);
    float roll = f3d_accel_calcTiltAngle(axF, ayF, azF, 1);
    
    float prevPitch = pitch;
    float prevRoll = roll;
    
    f3d_lcd_fillScreen(MAGENTA);
    
    f3d_lcd_drawString(10, 1, "Nunchuk Tilt Angle", BLACK, MAGENTA);
    
    delay(250);
    
    while(1) {
        if (user_btn_read()) {
            return 1;
        }
        
        f3d_nunchuk_read(&nunData);
	
        jx = nunData.jx;
	jy = nunData.jy;
	ax = nunData.ax - 500;
	axF = (float) (ax / 1000.0);
	ay = nunData.ay - 500;
	ayF = (float) (ay / 1000.0);
	az = nunData.az - 500;
	azF = (float) (az / 1000.0);
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
        
	pitch = f3d_accel_calcTiltAngle(axF, ayF, azF, 0);
	roll = f3d_accel_calcTiltAngle(axF, ayF, azF, 1);

	if ((pitch - prevPitch) > 0.1 || (pitch - prevPitch) < -0.1 || (roll - prevRoll) > 0.1 || (roll - prevRoll) < -0.1) {
	  char str[20];
	  
	  snprintf(str, sizeof(float) * 22, "ax: %5.3f ", axF);
	  f3d_lcd_drawString(2, 130, str, BLACK, MAGENTA);
	  
	  snprintf(str, sizeof(float) * 22, "ay: %5.3f ", ayF);
	  f3d_lcd_drawString(2, 140, str, BLACK, MAGENTA);
	  
	  snprintf(str, sizeof(float) * 22, "az: %5.3f ", azF);
	  f3d_lcd_drawString(2, 150, str, BLACK, MAGENTA);
	  
	  f3d_lcd_drawString(64, 80, "+", YELLOW, MAGENTA);
	  
	  int x1 = (64 + (prevRoll * 30) - 2);
	  int y1 = (80 + (prevPitch * 30) - 2);
	  int x2 = (64 + (prevRoll * 30) + 4);
	  int y2 = (80 + (prevPitch * 30) + 6);
	  f3d_lcd_fillScreenXYXY(x1, y1, x2, y2, MAGENTA);
	  
	  f3d_lcd_drawString(64 + (roll*30), 80 + (pitch*30), "*", BLACK, MAGENTA);
	  
	  prevRoll = roll;
	  prevPitch = pitch;
	}
    }
}

/* f3d_nunchuk.c ends here */
