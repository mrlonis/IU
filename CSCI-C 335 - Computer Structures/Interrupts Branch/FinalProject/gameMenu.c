/*
 * gameMenu.c
 *
 * Description: Game Menu used for Final Project
 *
 * Created On: 28 October 2017
 * Created By: Matthew Lonis & Alvaro Michael
 * Last Modified On: 8 December 2017
 * Last Modieified By: Matthew Lonis
 *
 * Part Of: Final Project
 */

#include <stm32f30x.h>  // Pull in include files for F30x standard drivers
#include <f3d_delay.h>
#include <f3d_lcd_sd.h>
#include <f3d_nunchuk.h>
#include <glcdfont.h>
#include <diskio.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <ff.h>

static nunchuk_t nunData;
static uint16_t colors[128];
static uint16_t i;

uint8_t gameMenu(void) {
  uint8_t selection = 0;
  uint8_t redraw = 1;
    
  f3d_lcd_fillScreen(BLACK);
  f3d_lcd_drawString(21, 1, "C335 Defense", WHITE, BLACK);
    
  while (1) {
    delay(10);
    f3d_nunchuk_read(&nunData);
        
    if (nunData.jy == 255 && selection != 0) {
      selection = 0;
      redraw = 1;
    } else if (nunData.jy == 0 && selection != 1) {
      selection = 1;
      redraw = 1;
    }
        
    if (nunData.c == 1) {
      if (selection == 0) {
	return 1;
      } else if (selection == 1) {
	return 2;
      }
    }
        
    if (selection == 0 && redraw == 1) {            
      for (i = 0; i < 108; i++) {
	colors[i] = WHITE;
      }
            
      f3d_lcd_setAddrWindow(9, 40, 116, 60, MADCTLGRAPHICS);
            
      for (i = 0; i < (60-40); i++) {
	f3d_lcd_pushColor(colors, 108);
      }
            
      f3d_lcd_drawString(21, 45, "New Game", BLACK, WHITE);
            
      for (i = 0; i < 108; i++) {
	colors[i] = BLACK;
      }
            
      f3d_lcd_setAddrWindow(9, 70, 116, 90, MADCTLGRAPHICS);
            
      for (i = 0; i < (60-40); i++) {
	f3d_lcd_pushColor(colors, 108);
      }
            
      f3d_lcd_drawString(21, 75, "Credits", WHITE, BLACK);
    } else if (selection == 1 && redraw == 1) { 
      for (i = 0; i < 108; i++) {
	colors[i] = BLACK;
      }
            
      f3d_lcd_setAddrWindow(9, 40, 116, 60, MADCTLGRAPHICS);
            
      for (i = 0; i < (60-40); i++) {
	f3d_lcd_pushColor(colors, 108);
      }
            
      f3d_lcd_drawString(21, 45, "New Game", WHITE, BLACK);
            
      for (i = 0; i < 108; i++) {
	colors[i] = WHITE;
      }
            
      f3d_lcd_setAddrWindow(9, 70, 116, 90, MADCTLGRAPHICS);
            
      for (i = 0; i < (60-40); i++) {
	f3d_lcd_pushColor(colors, 108);
      }
            
      f3d_lcd_drawString(21, 75, "Credits", BLACK, WHITE);
    }
        
    redraw = 0;
  }
}
