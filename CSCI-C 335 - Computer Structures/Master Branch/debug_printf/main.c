/* main.c
 *
 * Filename: main.c
 
 * Description (from Lab Assignment Web Pag on Course Website):
     - As mentioned above, you have been tasked with making an analysis of printf. Design a program where an led turns on and off in an infinite loop, then design a program where the same led turns on and off but with several calls to printf in between turning the led on and off. If you want style points (which are in no way equivalent to extra credit), allow the user to toggle between the two types of led strobes with the user button.
 
 * Author: Matthew Lonis
 * Maintainer: Matthew Lonis
 * Created: Thu Jan 10 11:23:43 2013
 * Last Modified On: 28 September 2017
 */

#include <stm32f30x.h> // Pull in include files for F30x standard drivers
#include <f3d_led.h> // Pull in include file for the local drivers
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <stdio.h>

#define TIMER 20000

/*
 * Simple looping delay function
 */
void delay(void) {
    int i = 2000000;
    while (i-- > 0) {
        asm("nop"); /* This stops it optimising code out */
    }
}

/*
 * Main Function
 */
int main(void) {
    /*
     * If you have your inits set up, this should turn your LCD screen red
     */
    f3d_uart_init();
    f3d_led_init();
    f3d_user_btn_init();
    
    /*
     * "Design a program where an led turns on and off in an infinite loop"
     */
    int i = 0;
    for (i = 0; i < 5; i++) {
        f3d_led_on(4);
        
	delay();

        f3d_led_off(4);

	delay();
    }
    
    /*
     * ", then design a program where the same led turns on and off but with several calls to printf in between turning the led on and off."
     */
    for (i = 0; i < 100; i++) {
        f3d_led_on(4);

	delay();
        
        printf("I'm going to start testing some printf statements\n");
        printf("Here's another printf\n");
        printf("Here's a printf that uses a variable bro: %d\n", i);
        
        f3d_led_off(4);

	delay();
    }
}

#ifdef USE_FULL_ASSERT
void assert_failed(uint8_t* file, uint32_t line) {
  /* Infinite loop */
  /* Use GDB to find out why we're here */
  while (1);
}
#endif
