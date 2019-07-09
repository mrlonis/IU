/* main.c ---
 *
 * Filename: main.c
 * Description:
 * Author:
 * Maintainer: Matthew Lonis
 * Created: Thu Jan 10 11:23:43 2013
 * Last Modified On: 19 October 2017
 /* Code: */

#include <math.h>
#include <stm32f30x.h> // Pull in include files for F30x standard drivers
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <f3d_lcd_sd.h>
#include <f3d_i2c.h>
#include <f3d_accel.h>
#include <f3d_mag.h>
#include <f3d_init.h>
#include <stdio.h>

#define TIMER 20000

int nunchuk_app(int nunchuk1, int init);

/*
 * Gyro app from Lab 5
 *
 * @param init  If init = 1, hardware needs initialized, otherwise nothing.
 */
int f3d_gyro_app(int nunchuk1, int init) {
    if (init) {
        f3d_init(nunchuk1, init);
    }
    
    nunchuk_t nunData;
    unsigned char jx;
    unsigned char c;
    unsigned char z;
    f3d_nunchuk_read(&nunData);
    jx = nunData.jx;
    c = nunData.c;
    z = nunData.z;
    int prevValue[3] = { -255, -255, -255};
    
    //draw lines
    int y;
    
    f3d_lcd_fillScreen(CYAN);
    
    // x y and z axis labels
    f3d_lcd_drawChar(17, 150, 120, BLACK, CYAN);
    f3d_lcd_drawChar(55, 150, 121, BLACK, CYAN);
    f3d_lcd_drawChar(92, 150, 122, BLACK, CYAN);
    
    while(y++ < 128) {
        f3d_lcd_drawPixel(y, 137, BLACK); // line above velocities
        //f3d_lcd_drawPixel(y, 70, BLACK); // 0 velocity graph axis
    }
    
    f3d_lcd_drawString(1, 67, "0", BLACK, CYAN);
    int q = 8;
    
    while (q < 128) {
        f3d_lcd_drawPixel(q++, 70, BLACK);
    }
    
    float velos[3];
    
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
        
        f3d_gyro_getdata(velos);
        int temp[3] = {(int) ceil(velos[0]), (int) ceil(velos[1]), (int)ceil(velos[2])};
        
        if ((temp[0] - prevValue[0]) > 1 || (temp[0] - prevValue[0]) < -1 || (temp[1] - prevValue[1]) > 1 || (temp[1] - prevValue[1]) < -1 || (temp[2] - prevValue[2]) > 1 || (temp[2] - prevValue[2]) < -1) {
            f3d_lcd_drawBarBlocks(15, prevValue[0],CYAN);
            f3d_lcd_drawBarBlocks(55, prevValue[1], CYAN);
            f3d_lcd_drawBarBlocks(95, prevValue[2], CYAN);
            
            char str[20];
            snprintf(str, sizeof(float) * 22, "%5.1f %5.1f %5.1f", velos[0], velos[1], velos[2]);
            f3d_lcd_drawString(2, 140, str, BLACK, CYAN);
            
            //draw graphs
            
            uint16_t colors[3];
            int i;
            
            for(i = 0; i < 3; i++) {
                if(temp[i] >= 0) {
                    colors[i] = GREEN;
                }
                else {
                    colors[i] = RED;
                }
            }
            
            f3d_lcd_drawBarBlocks(15, temp[0], colors[0]);
            f3d_lcd_drawBarBlocks(55, temp[1], colors[1]);
            f3d_lcd_drawBarBlocks(95, temp[2], colors[2]);
            
            delay(30);
            
            for (i = 0; i < 3; i++) {
                prevValue[i] = temp[i];
            }
        }
    }
}

int main(void) {
  f3d_init(1, 1);
  int count = 0;
  
  while (1) {
    if (count == 0) {
      count += f3d_gyro_app(0, 0);
    } else if (count == 1) {
      count += f3d_accel_app(0, 0);
    } else if (count == 2) {
      count += f3d_mag_app(0, 0);
    } else if (count == 3) {
      count += nunchuk_app(0, 0);
    }

    delay(250);
    
    /*
     * Data check to ensure count is always between 0 and 3
     */
    if (count > 3) {
      count = 0;
    } else if (count < 0) {
      count = 3;
    }
  }
}

#ifdef USE_FULL_ASSERT
void assert_failed(uint8_t* file, uint32_t line) {
    /* Infinite loop */
    /* Use GDB to find out why we're here */
    while (1);
}
#endif

int nunchuk_app(int nunchuk1, int init) {
    if (init) {
      f3d_init(nunchuk1, init);
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

/* main.c ends here */
