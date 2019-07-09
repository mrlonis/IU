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
#include <f3d_delay.h>
#include <f3d_i2c.h>
#include <f3d_init.h>
#include <f3d_lcd_sd.h>
#include <f3d_nunchuk.h>
#include <f3d_rtc.h>
#include <f3d_uart.h>
#include <glcdfont.h>
#include <diskio.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <ff.h>
#include "newGame.h"
#include "credits.h"
#include "gameMenu.h"

uint16_t main(void) {
    /*
     * Initialize drivers and setup code variable
     */
    f3d_init(1, 1);
    uint8_t x, y;
    uint8_t code = 0;
    
    while (1) {
        if (code == 0) {
            code = gameMenu();
        } else if (code == 1) {
            newGame();
            code = 2;
        } else if (code == 2) {
            credits();
            code = 0;
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
