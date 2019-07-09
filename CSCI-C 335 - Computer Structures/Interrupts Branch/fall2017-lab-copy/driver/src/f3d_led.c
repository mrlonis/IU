/************************
 *f3d_led.c - contains intializations/functions for the leds
 ************************/

#include <stm32f30x.h>
#include <stm32f30x_gpio.h>
#include <stm32f30x_rcc.h>
#include <f3d_led.h>


//intializes the port and pins for the leds on the board
void f3d_led_init(void) {
 
}
/*Turns on the appropriate led as specified by the parameter.*/
void f3d_led_on(int led) {
  /*YOUR CODE HERE*/
}

/*Turns off the approiate led as specified by the parameter*/ 
void f3d_led_off(int led) {
  /*YOUR CODE HERE*/
} 

/*Turns on all LEDs*/
void f3d_led_all_on(void) {
  /*YOUR CODE HERE*/
 
} 

/*Turns off all LEDs*/
void f3d_led_all_off(void) {
  /*YOUR CODE HERE*/
} 

/* led.c ends here */

