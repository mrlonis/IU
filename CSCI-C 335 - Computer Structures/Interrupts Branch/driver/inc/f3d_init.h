/**
 * f3d_init.h
 *
 * Created By: Matthew Lonis
 * Created On: 19 October 2017
 * Last Modified By: Matthew Lonis
 * LAst Modified On: 19 October 2017
 */

#include <f3d_accel.h>
#include <f3d_delay.h>
#include <f3d_gyro.h>
#include <f3d_i2c.h>
#include <f3d_lcd_sd.h>
#include <f3d_led.h>
#include <f3d_mag.h>
#include <f3d_uart.h>
#include <f3d_user_btn.h>

/*
 * This function initializes everything I have used in the course thus
 * far. The goal of this driver file is to speed up initializaion
 * coding for multiple apps
 */
void f3d_init(int nunchuk1, int interrupts);
