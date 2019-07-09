/* f3d_uart.h --- 
 * 
 * Filename: f3d_uart.h
 * Description: Header for f3d_uart.c
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Sep 26 07:05:43 2013
 * Last-Updated: 5 October 2017
 *           By: Matthew Lonis
 *     Update #: 2
 * Partner: Alvaro Michael
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

void f3d_uart_init(void);
int putchar(int);
int getchar(void);
void putstring(char *);

/* f3d_uart.h ends here */
