/**
 * main.c
 *
 * Description: Main used for Final Project
 *
 * Created On: 28 October 2017
 * Created By: Matthew Lonis
 * Last Modified On: 28 October 2017
 * Last Modieified By: Matthew Lonis
 *
 * Part Of: Final Project
 */

#include <stm32f30x.h>  // Pull in include files for F30x standard drivers
#include <f3d_accel.h>
#include <f3d_delay.h>
#include <f3d_gyro.h>
#include <f3d_i2c.h>
#include <f3d_init.h>
#include <f3d_lcd_sd.h>
#include <f3d_led.h>
#include <f3d_mag.h>
#include <f3d_nunchuk.h>
#include <f3d_rtc.h>
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <glcdfont.h>
#include <diskio.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <ff.h>

int main(void) {
    f3d_init();
    int code = 0;
    
    while (1) {
        if (code == 0) {
            code = f3d_lcd_game();
        }
    }
}
