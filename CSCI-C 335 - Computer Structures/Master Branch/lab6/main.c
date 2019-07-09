/* 
 * Filename: main.c
 * 
 * Description: main.c file from Lab 6 that runs LCD App
 * 
 * Created By: Matthew Lonis
 * Created On: 29 September 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: 13 October 2017
 */

#include <stm32f30x.h> // Pull in include files for F30x standard drivers
#include <f3d_led.h> // Pull in include file for the local drivers
#include <f3d_uart.h>
#include <f3d_gyro.h>
#include <f3d_lcd_sd.h>
#include <f3d_delay.h>
#include <stdio.h>

#define TIMER 20000

float gyroData[3];
float prevX;
float prevY;
float prevZ;
int prevXCieling;
int prevYCieling;
int prevZCieling;

int width = 128;
int height = 160;

int dataLabels = 42;

int left = 8;
int midLeft = 48;
int midRight = 88;
int right = 127;

int axis = 110;
int top = 55;
int bottom = 159;

void drawInitial(void) {
    /*
     * Sets us Data Information Fields
     */
    f3d_lcd_drawString(1, 1, "Current Gyro Data", BLACK, WHITE);
    f3d_lcd_drawString(1, 10, "X-Axis:", BLACK, WHITE);
    f3d_lcd_drawString(1, 18, "Y-Axis:", BLACK, WHITE);
    f3d_lcd_drawString(1, 26, "Z-Axis:", BLACK, WHITE);
    
    
    /*
     * Used to draw Dividing Line
     */
    int x = 0;
    int y = 35;
    
    for (x = 0; x < 129; x++) {
        f3d_lcd_drawPixel(x, y, BLACK);
    }
    
    /*
     * Start Drawing Graph Information
     */
    f3d_lcd_drawString(51, 38, "Graphs", BLACK, WHITE);
    f3d_lcd_drawString(26, 47, "X", BLUE, WHITE);
    f3d_lcd_drawString(66, 47, "Y", RED, WHITE);
    f3d_lcd_drawString(105, 47, "Z", GREEN, WHITE);
    f3d_lcd_drawString(1, 80, "+", BLACK, WHITE);
    f3d_lcd_drawString(1, 132, "-", BLACK, WHITE);
    
    /*
     * Lines to Divide Bar Charts
     */
    // Top horz line
    for (x = left, y = top; x < width; x++) {
        f3d_lcd_drawPixel(x, y, BLACK);
    }
    
    // Bottom horz line
    for (x = left, y = bottom; x < width; x++) {
        f3d_lcd_drawPixel(x, y, BLACK);
    }
    
    // Middle horz line
    for (x = left, y = axis; x < width; x++) {
        f3d_lcd_drawPixel(x, y, BLACK);
    }
    
    // Left Vert Line
    for (x = left, y = top; y < height; y++) {
        f3d_lcd_drawPixel(x, y, BLACK);
    }
    
    // Right Vert Line
    for (x = right, y = top; y < height; y++) {
        f3d_lcd_drawPixel(x, y, BLACK);
    }
    
    // Left-Mid Vert Line
    for (x = midLeft, y = top; y < height; y++) {
        f3d_lcd_drawPixel(x, y, BLACK);
    }
    
    // Right-Mid Vert Line
    for (x = midRight, y = top; y < height; y++) {
        f3d_lcd_drawPixel(x, y, BLACK);
    }
}

/**
 * To make things easy, the following described the inputs
 *
 * graph:
 *        - 0 = X
 *        - 1 = Y
 *        - 2 = Z
 *
 * direction:
 *            - 1 = Positive
 *            - 0 = Negative
 */
void set_addrWindow(int graph, int direction) {
  if (graph == 0) {
    if (direction) {
      f3d_lcd_setAddrWindow(left+1, top+1, midLeft-1, axis-1, MADCTLGRAPHICS);
    } else {
      f3d_lcd_setAddrWindow(left+1, axis+1, midLeft-1, bottom-1, MADCTLGRAPHICS);
    }
  } else if (graph == 1) {
    if (direction) {
      f3d_lcd_setAddrWindow(midLeft+1, top+1, midRight-1, axis-1, MADCTLGRAPHICS);
    } else {
      f3d_lcd_setAddrWindow(midLeft+1, axis+1, midRight-1, bottom-1, MADCTLGRAPHICS);
    }
  } else {
    if (direction) {
      f3d_lcd_setAddrWindow(midRight+1, top+1, right-1, axis-1, MADCTLGRAPHICS);
    } else {
      f3d_lcd_setAddrWindow(midRight+1, axis+1, right-1, bottom-1, MADCTLGRAPHICS);
    }
  }
}

void drawXData(void) {
    char xData[50];
    sprintf(xData, "%f", gyroData[0]);
    
    f3d_lcd_drawString(dataLabels, 10, xData, BLACK, WHITE);
}

void drawXGraph(void) {
    /*
     * Local Variables
     */
    float xData = gyroData[0];
    int x = 0;
    int y = 0;
    float xDataEdit = 0;
    int cieling = 0;
    
    /*
     * Calculate new cieling
     */
    xDataEdit = xData / 4;
    
    if (xDataEdit < 0) {
        cieling = 111 - xDataEdit;
    } else {
        cieling = 109 - xDataEdit;
    }
    
    if (cieling > 158) {
        cieling = 158;
    } else if (cieling < 56) {
        cieling = 56;
    }

    if (prevXCieling == 0) {
      prevXCieling = cieling;
    }
    
    /*
     * Clears part of graph not going to be used for updated graph data
     */
    if (prevXCieling > cieling && cieling > axis && prevXCieling > axis) {
        /*
         * This if statement represents the situation in which the previous
         * negative cieling is greater than the new negative cieling. What needs to be done is
         * clearing the graph.
         */
        for (x = left + 1; x < midLeft; x++) {
            for (y = cieling + 1; y <= prevXCieling; y++) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
    } else if (prevXCieling < cieling && cieling > axis && prevXCieling > axis) {
        /*
         * This if statement represents the situation in which the previous
         * negative cieling is less than the new negative cieling. What needs to be done is
         * adding to the graph.
         */
        for (x = left + 1; x < midLeft; x++) {
            for (y = prevXCieling + 1; y <= cieling; y++) {
                f3d_lcd_drawPixel(x, y, BLUE);
            }
        }
    } else if (prevXCieling > cieling && cieling < axis && prevXCieling < axis) {
        /*
         * This if statement represents the situation in which the previous
         * positive cieling is greater than the new positive cieling. What needs
         * to be done is adding to the graph.
         */
        for (x = left + 1; x < midLeft; x++) {
            for (y = prevXCieling + 1; y >= cieling; y--) {
                f3d_lcd_drawPixel(x, y, BLUE);
            }
        }
    } else if (prevXCieling < cieling && cieling < axis && prevXCieling < axis) {
        /*
         * This if statement represents the situation in which the previous
         * positive cieling is less than the new positive cieling. What needs
         * to be done is clearing the graph.
         */
        for (x = left + 1; x < midLeft; x++) {
            for (y = cieling + 1; y >= prevXCieling; y--) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
    } else if (cieling < axis && prevXCieling > axis) {
        /*
         * This if statement represents the situation in which the graph is going
         * from a negative graph to a positive one. What needs to be done is clearing
         * the negative portion of the graph and drawing the new positive portion of
         * the graph
         */
        for (x = left + 1; x < midLeft; x++) {
            for (y = axis + 1; y <= prevXCieling; y++) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
        
        for (x = left + 1; x < midLeft; x++) {
            for (y = axis - 1; y >= cieling; y--) {
                f3d_lcd_drawPixel(x, y, BLUE);
            }
        }
    } else if (cieling > axis && prevXCieling < axis) {
        /*
         * This if statement represents the situation in which the graph is going
         * from a positive graph to a negative one. What needs to be done is clearing
         * the positive portion of the graph and drawing the new negative portion of
         * the graph
         */
        for (x = left + 1; x < midLeft; x++) {
            for (y = axis - 1; y >= prevXCieling; y--) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
        
        for (x = left + 1; x < midLeft; x++) {
            for (y = axis + 1; y <= cieling; y++) {
                f3d_lcd_drawPixel(x, y, BLUE);
            }
        }
    }

    prevXCieling = cieling;
}

void drawYData(void) {
    char yData[50];
    sprintf(yData, "%f", gyroData[1]);
    
    f3d_lcd_drawString(dataLabels, 18, yData, BLACK, WHITE);
}

void drawYGraph(void) {
    /*
     * Local Variables
     */
    float yData = gyroData[1];
    int x = 0;
    int y = 0;
    float yDataEdit = 0;
    int cieling = 0;
    
    /*
     * Calculate new cieling
     */
    yDataEdit = yData / 4;
    
    if (yDataEdit <= 0) {
        cieling = 111 - yDataEdit;
    } else {
        cieling = 109 - yDataEdit;
    }
    
    if (cieling > 158) {
        cieling = 158;
    } else if (cieling < 56) {
        cieling = 56;
    }

    if (prevYCieling == 0) {
      prevYCieling = cieling;
    }
    
    /*
     * Clears part of graph not going to be used for updated graph data
     */
    if (prevYCieling > cieling && cieling > 110 && prevYCieling > 110) {
        /*
         * This if statement represents the situation in which the previous
         * negative cieling is greater than the new negative cieling. What needs to be done is
         * clearing the graph.
         */
        for (x = midLeft + 1; x < midRight; x++) {
            for (y = cieling + 1; y <= prevYCieling; y++) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
    } else if (prevYCieling < cieling && cieling > 110 && prevYCieling > 110) {
        /*
         * This if statement represents the situation in which the previous
         * negative cieling is less than the new negative cieling. What needs to be done is
         * adding to the graph.
         */
        for (x = midLeft + 1; x < midRight; x++) {
            for (y = prevYCieling + 1; y <= cieling; y++) {
                f3d_lcd_drawPixel(x, y, RED);
            }
        }
    } else if (prevYCieling > cieling && cieling < 110 && prevYCieling < 110) {
        /*
         * This if statement represents the situation in which the previous
         * positive cieling is greater than the new positive cieling. What needs
         * to be done is adding to the graph.
         */
        for (x = midLeft + 1; x < midRight; x++) {
            for (y = prevYCieling + 1; y >= cieling; y--) {
                f3d_lcd_drawPixel(x, y, RED);
            }
        }
    } else if (prevYCieling < cieling && cieling < 110 && prevYCieling < 110) {
        /*
         * This if statement represents the situation in which the previous
         * positive cieling is less than the new positive cieling. What needs
         * to be done is clearing the graph.
         */
        for (x = midLeft + 1; x < midRight; x++) {
            for (y = cieling + 1; y >= prevYCieling; y--) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
    } else if (cieling < 110 && prevYCieling > 110) {
        /*
         * This if statement represents the situation in which the graph is going
         * from a negative graph to a positive one. What needs to be done is clearing
         * the negative portion of the graph and drawing the new positive portion of
         * the graph
         */
        for (x = midLeft + 1; x < midRight; x++) {
            for (y = axis + 1; y <= prevYCieling; y++) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
        
        for (x = midLeft + 1; x < midRight; x++) {
            for (y = axis - 1; y >= cieling; y--) {
                f3d_lcd_drawPixel(x, y, RED);
            }
        }
    } else if (cieling > 110 && prevYCieling < 110) {
        /*
         * This if statement represents the situation in which the graph is going
         * from a positive graph to a negative one. What needs to be done is clearing
         * the positive portion of the graph and drawing the new negative portion of
         * the graph
         */
        for (x = midLeft + 1; x < midRight; x++) {
            for (y = axis - 1; y >= prevYCieling; y--) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
        
        for (x = midLeft + 1; x < midRight; x++) {
            for (y = axis + 1; y <= cieling; y++) {
                f3d_lcd_drawPixel(x, y, RED);
            }
        }
    }

    prevYCieling = cieling;
}

void drawZData(void) {
    char zData[50];
    sprintf(zData, "%f", gyroData[2]);
    
    f3d_lcd_drawString(dataLabels, 26, zData, BLACK, WHITE);
}

void drawZGraph(void) {
    /*
     * Local Variables
     */
    float zData = gyroData[2];
    int x = 0;
    int y = 0;
    float zDataEdit = 0;
    int cieling = 0;
    
    /*
     * Calculate new cieling
     */
    zDataEdit = zData / 4;
    
    if (zDataEdit < 0) {
        cieling = 111 - zDataEdit;
    } else {
        cieling = 109 - zDataEdit;
    }
    
    if (cieling > 158) {
        cieling = 158;
    } else if (cieling < 56) {
        cieling = 56;
    }

    if (prevZCieling == 0) {
      prevZCieling = cieling;
    }
    
    /*
     * Clears part of graph not going to be used for updated graph data
     */
    if (prevZCieling > cieling && cieling > axis && prevZCieling > axis) {
        /*
         * This if statement represents the situation in which the previous
         * negative cieling is greater than the new negative cieling. What needs to be done is
         * clearing the graph.
         */
        for (x = midRight + 1; x < right; x++) {
            for (y = cieling + 1; y <= prevZCieling; y++) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
    } else if (prevZCieling < cieling && cieling > 110 && prevZCieling > 110) {
        /*
         * This if statement represents the situation in which the previous
         * negative cieling is less than the new negative cieling. What needs to be done is
         * adding to the graph.
         */
      printf("Previous negative cieling is less than the new negative cieling\n");

        for (x = midRight + 1; x < right; x++) {
            for (y = prevZCieling + 1; y <= cieling; y++) {
                f3d_lcd_drawPixel(x, y, GREEN);
            }
        }
    } else if (prevZCieling > cieling && cieling < 110 && prevZCieling < 110) {
        /*
         * This if statement represents the situation in which the previous
         * positive cieling is greater than the new positive cieling. What needs
         * to be done is adding to the graph.
         */
        for (x = midRight + 1; x < right; x++) {
            for (y = prevZCieling + 1; y >= cieling; y--) {
                f3d_lcd_drawPixel(x, y, GREEN);
            }
        }
    } else if (prevZCieling < cieling && cieling < 110 && prevZCieling < 110) {
        /*
         * This if statement represents the situation in which the previous
         * positive cieling is less than the new positive cieling. What needs
         * to be done is clearing the graph.
         */
        for (x = midRight + 1; x < right; x++) {
            for (y = cieling + 1; y >= prevZCieling; y--) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
    } else if (cieling < 110 && prevZCieling > 110) {
        /*
         * This if statement represents the situation in which the graph is going
         * from a negative graph to a positive one. What needs to be done is clearing
         * the negative portion of the graph and drawing the new positive portion of
         * the graph
         */
        for (x = midRight + 1; x < right; x++) {
            for (y = axis + 1; y <= prevZCieling; y++) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
        
        for (x = midRight + 1; x < right; x++) {
            for (y = axis - 1; y >= cieling; y--) {
                f3d_lcd_drawPixel(x, y, GREEN);
            }
        }
    } else if (cieling > 110 && prevZCieling < 110) {
        /*
         * This if statement represents the situation in which the graph is going
         * from a positive graph to a negative one. What needs to be done is clearing
         * the positive portion of the graph and drawing the new negative portion of
         * the graph
         */
        for (x = midRight + 1; x < right; x++) {
            for (y = axis - 1; y >= prevZCieling; y--) {
                f3d_lcd_drawPixel(x, y, WHITE);
            }
        }
        
        for (x = midRight + 1; x < right; x++) {
            for (y = axis + 1; y <= cieling; y++) {
                f3d_lcd_drawPixel(x, y, GREEN);
            }
        }
    }

    prevZCieling = cieling;
}

int main(void) {
  int x;
  int y;
  // If you have your inits set up, this should turn your LCD screen red
  f3d_lcd_init();
  f3d_uart_init();
  f3d_gyro_init();
  f3d_delay_init();
  f3d_lcd_fillScreen(WHITE);
  
  //printf("Welcome to my Lab 6 Application!\n");
  
  drawInitial();
  
  prevXCieling = 0;
  prevYCieling = 0;
  prevZCieling = 0;
  
  uint16_t xBlue[midLeft - left];
  for (y = 0; y < (midLeft - left); y++) { 
    xBlue[y] = BLUE;
  }

 uint16_t xWhite[midLeft - left];
  for (y = 0; y < (midLeft - left); y++) { 
    xWhite[y] = WHITE;
  }

 uint16_t yRed[midRight - midLeft];
  for (y = 0; y < (midRight - midLeft); y++) { 
    yRed[y] = RED;
  }

 uint16_t yWhite[midRight - midLeft];
  for (y = 0; y < (midRight - midLeft); y++) { 
    yWhite[y] = WHITE;
  }

 uint16_t zGreen[right - midRight];
  for (y = 0; y < (right - midRight); y++) { 
    zGreen[y] = GREEN;
  }

 uint16_t zWhite[right - midRight];
  for (y = 0; y < (right - midRight); y++) { 
    zWhite[y] = WHITE;
  }
  
  /*
   * Resolution of LCD is 128 x 160
   */
  while(1) {
    f3d_gyro_getdata(gyroData);
    
    /*
     * Update drawn textual data
     */
    drawXData();
    drawYData();
    drawZData();
    
    /*
     * Update bar graphs
     */
    drawXGraph();
    drawYGraph();
    drawZGraph();
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
