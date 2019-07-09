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

int main(void) {
  f3d_init();
  int count = 0;
  
  while (1) {
    if (count == 0) {
      count += f3d_gyro_app(0);
    } else if (count == 1) {
      count += f3d_accel_app(0);
    } else if (count == 2) {
      count += f3d_mag_app(0);
    } else if (count == 3) {
      count += f3d_nunchuk_app(0);
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

/* main.c ends here */
