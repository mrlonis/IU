/* f3d_systick.c --- 
 * 
 * Filename: f3d_systick.c
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Nov 14 07:57:37 2013
 * Last-Updated: 5 Ocotber 2017
 *           By: Matthew Lonis
 *     Update #: 1
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
 * 5 October 2017:
 *  - Header Changes
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
#include <f3d_systick.h>
#include <f3d_timer2.h>
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <glcdfont.h>
#include <diskio.h>
#include <ff.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <queue.h>

volatile int systick_flag = 0;

void f3d_systick_init(int fps) {
  SysTick_Config(SystemCoreClock/fps);
}

void SysTick_Handler(void) {
  /*
  if (user_btn_read()) {
    if (interrupts_counter_whatever % 10 == 0) {
      f3d_led_interrupts_app();
      interrupts_counter_whatever = 0;
    }
    
    interrupts_counter_whatever++;
  } else if (!user_btn_read()) {
    f3d_led_interrupts_app();
  }
  */
  if (!queue_empty(&txbuf)) {
    flush_uart();
  }
  
}

/* f3d_systick.c ends here */
