/* f3d_uart.h ---
 *
 * Filename: f3d_uart.h
 * Author: Rui Xi, zhiwlin
 * Created: 9 21 2017
 * Last-Updated:9 21 2017
 *           By: Rui Xi
 */


/* Copyright (c) 2004-2007 The Trustees of Indiana University and
 * Indiana University Research and Technology Corporation.
 *
 * All rights reserved.
 *
 * Additional copyrights may follow
 */

/* Code: */

void f3d_uart_init(void);
int putchar(int);
int getchar(void);
void flush_uart(void);
void USART1_IRQHandler(void);
void putstring(char *);

/* f3d_uart.h ends here */
