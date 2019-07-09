/*********************************
 * main.c 
 *
 * Main driver for LED sequencing
 *
 * Created By: Matthew Lonis
 * Created On: 8 September 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: 8 September 2017
 * Part Of: Lab 3
 *
 * Lab Partner: Nathan Lowry (ndlowry)
 *********************************/

#include <stm32f30x.h>  // Pull in include files for F30x standard drivers 
#include <f3d_led.h>     // Pull in include file for the local drivers
#include <f3d_user_btn.h>

// Simple looping delay function
void delay(void) {
  int i = 2000000;
  while (i-- > 0) {
    asm("nop"); /* This stops it optimising code out */
  }
}

int main(void) {
  f3d_led_init();
  f3d_user_btn_init();

  int i = 1;
  while (1) {
    while (user_btn_read() != 1) {
      if (i > 0 && i < 8 && i != 1) {
	f3d_led_off(i - 1);
      } else if (i == 0) {
	f3d_led_off(7);
      } else {
	f3d_led_all_off();
      }
      
      while (user_btn_read()) {

      }

      if(i < 8) {
	f3d_led_on(i);
      } else if (i == 8) {
	f3d_led_all_on();
      }

      while (user_btn_read()) {

      }

      delay();
      
      while (user_btn_read()) {

      }

      if (i < 7 && i >= 1) {
	i++;
      } else if (i == 7) {
	i = 0;
      } else if (i == 0) {
	i = 8;
      } else if (i == 8) {
	i = 1;
      }

      //i = (i+1)%9;
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
