/**
 * f3d_init.c
 *
 * Created By: Matthew Lonis
 * Created On: 19 October 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: 19 October 2017
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
#include <f3d_systick.h>
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <glcdfont.h>
#include <diskio.h>
#include <ff.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

/*
 * This function initializes everything I have used in the course thus
 * far. The goal of this driver file is to speed up initializaion
 * coding for multiple apps
 */
void f3d_init(int interrupts) {
  setvbuf(stdin, NULL, _IONBF, 0);
  setvbuf(stdout, NULL, _IONBF, 0);
  setvbuf(stderr, NULL, _IONBF, 0);

  f3d_led_init(); 

  f3d_uart_init();
  printf("Initialization starting...\n");

  f3d_delay_init();
  f3d_rtc_init();
  delay(100);
  
  f3d_gyro_init();
  f3d_lcd_init();
  delay(100);
  
  f3d_user_btn_init();
  delay(10);
  f3d_nunchuk_init();
  delay(10);
  
  f3d_i2c1_init();
  delay(10);
  f3d_accel_init();
  delay(10);
  f3d_mag_init();
  delay(10);
  f3d_lcd_fillScreen(WHITE);

  f3d_led_all_on();
  delay(250);
  f3d_led_all_off();
  delay(250);

  if (interrupts) {
    f3d_systick_init();
  }
  
  printf("Initialization succeeded\n");
}
