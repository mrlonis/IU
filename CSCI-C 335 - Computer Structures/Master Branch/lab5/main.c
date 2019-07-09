/**
 * main.c
 * 
 * Created On: 22 September 2017
 * Created By: Matthew Lonis
 * Last Modified On: 5 October 2017
 * Last Modified By: Matthew Lonis
 * 
 * Partner: Jiebo Wang
 */ 

#include <f3d_uart.h>
#include <stdio.h>
#include <f3d_gyro.h>
#include <f3d_led.h>
#include <f3d_user_btn.h>
#include <math.h>

float gyroData[3];
char axis = 'x';
int axisIndex = 0;
float minimumValue = 5;
float rangeOne = 75;
float rangeTwo = 150;
float rangeThree = 225;
float maximumValue = 300;

// Simple looping delay function
void delay(void) {
  int i = 2000000;
  while (i-- > 0) {
    asm("nop"); /* This stops it optimising code out */
  }
}

//gets a character
int askForChar(void) {
  if (USART_GetFlagStatus(USART1, USART_FLAG_RXNE) == (uint16_t)RESET);
  return USART_ReceiveData(USART1);
}

/*
 * Changes the axis to read from on the gyro
 */
void changeAxis(void) {
  if (user_btn_read()) {
    if (axis == 'x') {
      axis = 'y';
      axisIndex = 1;
      printf("Switched to y-axis!\n");
    } else if (axis == 'y') {
      axis = 'z';
      axisIndex = 2;
      printf("Switched to z-axis!\n");
    } else if (axis == 'z') {
      axis = 'x';
      axisIndex = 0;
      printf("Switched to x-axis!\n");
    }
  } 
}

/*
 * Chanegs trhe axis to the axius of the character that is given to the fucntion.
 */
void changeAxisViaChar(char c) {
  if ((c == 'x' || c == 'X') && axis != 'x') {
    axis = 'x';
    axisIndex = 0;
    printf("Switched to x-axis!\n");
  } else if ((c == 'y' || c == 'Y') && axis != 'y') {
    axis = 'y';
    axisIndex = 1;
    printf("Switched to y-axis!\n");
  } else if ((c == 'z' || c == 'Z') && axis != 'z') {
    axis = 'z';
    axisIndex = 2;
    printf("Switched to z-axis!\n");
  }
}

/*
 * Fucntion that lights the leds based on a particular float number
 */
void lightLEDs(float currentData) {
  f3d_led_all_off();

  if (currentData <= -5) {
    float posCurData = -1 * currentData;
    f3d_led_on(1);

    if (posCurData >= maximumValue) {
      f3d_led_on(2);
      f3d_led_on(3);
      f3d_led_on(4);
      f3d_led_on(5);
    } else if (posCurData >= rangeThree) {
      f3d_led_on(2);
      f3d_led_on(3);
      f3d_led_on(4);
    } else if (posCurData >= rangeTwo) {
      f3d_led_on(2);
      f3d_led_on(3);
    } else if (posCurData >= rangeOne) {
      f3d_led_on(2);
    }
  } else if (currentData >=5) {
    f3d_led_on(1);

    if (currentData >= maximumValue) {
      f3d_led_on(0);
      f3d_led_on(7);
      f3d_led_on(6);
      f3d_led_on(5);
    } else if (currentData >= rangeThree) {
      f3d_led_on(0);
      f3d_led_on(7);
      f3d_led_on(6);
    } else if (currentData >= rangeTwo) {
      f3d_led_on(0);
      f3d_led_on(7);
    } else if (currentData >= rangeOne) {
      f3d_led_on(0);
    }
  } else {
    f3d_led_all_off();
  }
}

/*
 * Main function
 */
int main(void){
  /*
   * Initialize hardware
   */
  f3d_uart_init();
  f3d_gyro_init();
  f3d_led_init();
  f3d_user_btn_init();

  setvbuf(stdin, NULL, _IONBF, 0);
  setvbuf(stdout, NULL, _IONBF, 0);
  setvbuf(stderr, NULL, _IONBF, 0);

  /*
   * Application Welcome Message
   */
  printf("Welcome to my Angular Velocity Visualization Application!\n");
  printf("Press the user button at anytime to change the current axis.\n");

  while(1) {
    int cInt = askForChar();
    char c = (char) cInt;

    /*
     * Checks if cInt is equal to the ascii values for 'X', 'Y', 'Z', 'x', 'y', and 'z'
     */
    if (c == 'x' || c == 'X' ||c == 'y' || c == 'Y' || c == 'z' || c == 'Z') {
      changeAxisViaChar(c);
    } else if(user_btn_read()) {
      changeAxis();
    }
    
    f3d_gyro_getdata(gyroData);
    float currentData = gyroData[axisIndex];
      
      /*
     * Light the appropriate leds
     */
      lightLEDs(currentData);

      c = (char) 20;
  }
}

void assert_failed(uint8_t* file, uint32_t line) {
/* Infinite loop */
/* Use GDB to find out why we're here */
  while (1);
}

/* main.c ends here */