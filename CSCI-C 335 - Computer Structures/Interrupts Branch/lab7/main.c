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
/*
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <f3d_lcd_sd.h>
#include <f3d_i2c.h>
 */
#include <f3d_accel.h>
#include <f3d_mag.h>
#include <f3d_init.h>
#include <stdio.h>

#define TIMER 20000

int arrow[31][2] = { {64, 65}, {64, 66}, {64, 67}, {64, 68}, {64, 69}, {64, 70}, {64, 71}, {64, 72}, {64, 73}, {64, 74}, {64, 75}, {64, 76}, {64, 77}, {64, 78}, {64, 79}, {64, 80}, {64, 81}, {64, 82}, {64, 83}, {64, 84}, {64, 85},  {64, 86}, {64, 87}, {64, 88}, {64, 89}, {64, 90}, {64, 91}, {64, 92}, {64, 93}, {64, 94}, {64, 95} };

/**
 * Accelerometer app that displays a compass on the LCD. Made this in Lab 7.
 *
 * @param init  If this value = 1, the baord utils have not been initialized and need to be.
 */
int f3d_accel_app(int nunchuk1, int init) {
    if (init) {
        f3d_init(nunchuk1, init);
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

/**
 * Magnetometer app that displays a compass on the LCD. Made this in Lab 7.
 *
 * @param init  If this value = 1, the baord utils have not been initialized and need to be.
 */
int f3d_mag_app(int nunchuk1, int init) {
    if (init) {
        f3d_init(nunchuk1, init);
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

int main(void) {
    f3d_init(1, 1);

    while (1) {
      f3d_accel_app(0, 0);
      f3d_mag_app(0, 0);
    }
}

#ifdef USE_FULL_ASSERT
void assert_failed(uint8_t* file, uint32_t line) {
    /* Infinite loop */
    /* Use GDB to find out why we're here */
    while (1);
}
#endif

/* main.c ends here */
