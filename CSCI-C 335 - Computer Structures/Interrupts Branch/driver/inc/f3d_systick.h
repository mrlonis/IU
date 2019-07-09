/* f3d_systick.h --- 
 * 
 * Filename: f3d_systick.h
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Nov 14 08:02:24 2013
 * Last-Updated: 5 October 2017
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
#include <stm32f30x.h>

#define SYSTICK_INT_SEC 100

int interrupts_counter_whatever;

void f3d_systick_init(int fps);

void SysTick_Handler(void);

/* f3d_systick.h ends here */

