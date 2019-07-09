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

int main(void) {
  /*
    setvbuf(stdin, NULL, _IONBF, 0);
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
    
    // Set up your inits before you go ahead
    
    f3d_i2c1_init();
    delay(10);
    f3d_accel_init();
    delay(10);
    f3d_mag_init();
    delay(10);
    
    f3d_lcd_init();
    f3d_lcd_fillScreen(WHITE);
    f3d_uart_init();
    f3d_user_btn_init();
     */
    
    f3d_init();

    while (1) {
      f3d_accel_app(0);
      f3d_mag_app(0);
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
