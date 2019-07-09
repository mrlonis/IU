/* f3d_lcd_sd.c --- 
 *
 * Filename: f3d_lcd_sd.c
 * Description:
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Oct 24 05:18:36 2013
 * Last-Updated: 1 November 2017
 *           By: Matthew Lonis
 *     Update #: 2
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
 *  - Header changes
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

#include <stm32f30x.h>  // Pull in include files for F30x standard drivers 
#include <f3d_accel.h>
#include <f3d_delay.h>
#include <f3d_gyro.h>
#include <f3d_i2c.h>
#include <f3d_init.h>
#include <f3d_lcd_sd.h>
#include <f3d_led.h>
#include <f3d_mag.h>
#include <f3d_nunchuk.h>
#include <f3d_rtc.h>
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <glcdfont.h>
#include <diskio.h>
#include <ff.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

/**
 * Global variables used in applications
 */
static nunchuk_t nunData;
static float accel[3];

static int redraw;
static int code;
static uint8_t orientation;

static float pitch;
static float roll;
static float prevPitch;
static float prevRoll;

int f3d_lcd_nunchukDataUpdates(void) {
  /*
   * Initial checks at start of every loop to update data
   */
  f3d_nunchuk_read(&nunData);
  int change = 0;
    
  if (nunData.c == 1) {
    code++;
    redraw = 1;
    change = 1;
  } else if (nunData.z == 1) {
    code--;
    redraw = 1;
    change = 1;
  }
    
  if (nunData.jx > 200) {
    code++;
    redraw = 1;
    change = 1;
  } else if (nunData.jx < 55) {
    code--;
    redraw = 1;
    change = 1;
  }
    
  if (code < 0) {
    code = 2;
    redraw = 1;
    change = 1;
  } else if (code > 2) {
    code = 0;
    redraw = 1;
    change = 1;
  }
    
  if (change == 1) {
    delay(50);
    return 1;
  } else {
    return 0;
  }
}

int f3d_lcd_accelDataUpdates(void) {
  f3d_accel_read(accel);

  int change = 0;
    
  pitch = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 0);
  roll = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 1);

  printf("Pitch = %f | Roll = %f\n", pitch, roll);

  if (abs(roll) > abs(pitch)) {
    if ((roll - prevRoll) > 0.5) {
      // Left
      orientation = 0x3;
      redraw = 1;
      f3d_lcd_fillScreen(BLACK);
      change = 1;
    } else if ((roll - prevRoll) < -0.5) {
      // Right
      orientation = 0x5;
      redraw = 1;
      f3d_lcd_fillScreen(BLACK);
      change = 1;
    }
  } else {
    if ((pitch - prevPitch) > 0.5) {
      // Down
      orientation = 0x6;
      redraw = 1;
      f3d_lcd_fillScreen(BLACK);
      change = 1;
    } else if ((pitch - prevPitch) < -0.5) {
      // Up
      orientation = 0x2;
      redraw = 1;
      f3d_lcd_fillScreen(BLACK);
      change = 1;
    }
  }
  
  prevRoll = roll;
  prevPitch = pitch;
    
  if (change) {
    return 1;
  } else {
    return 0;
  }
}

struct bmpfile_magic {
  unsigned char magic[2];
};

struct bmpfile_header {
  uint32_t filesz;
  uint16_t creator1;
  uint16_t creator2;
  uint32_t bmp_offset;
};

typedef struct {
  uint32_t header_sz;
  int32_t width;
  int32_t height;
  uint16_t nplanes;
  uint16_t bitspp;
  uint32_t compress_type;
  uint32_t bmp_bytesz;
  int32_t hres;
  int32_t vres;
  uint32_t ncolors;
  uint32_t nimpcolors;
} BITMAPINFOHEADER;

struct bmppixel { // little endian byte order
  uint8_t b;
  uint8_t g;
  uint8_t r;
};

struct lcd_cmdBuf {
  uint8_t command;
  uint8_t delay;
  uint8_t len;
  uint8_t data [16];
};

static uint8_t madctlcurrent = MADVAL(MADCTLGRAPHICS);

static FATFS Fatfs;		// File system object
static FIL Fil;		// File object
static BYTE Buff[128];		// File read buffer

static FRESULT rc;		// Result code
static DIR dir;		// Directory object
static FILINFO fno;		// File information object
static UINT bw, br;
static unsigned int retval;

static struct bmpfile_magic magic;
static struct bmpfile_header header;
static BITMAPINFOHEADER info;
static struct bmppixel pixel;

void f3d_lcd_sd_interface_init(void) {
  /* vvvvvvvvvvv pin initialization for the LCD goes here vvvvvvvvvv*/
    
  /*
   * Pin Mode: OUT Pins
   */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, ENABLE);
    
  GPIO_InitTypeDef GPIO_InitStructure;
  GPIO_StructInit(&GPIO_InitStructure);
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9 | GPIO_Pin_10 | GPIO_Pin_11 | GPIO_Pin_12;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
    
  GPIO_Init(GPIOB, &GPIO_InitStructure);
    
  /*
   * Pin Mode: AF Pins
   */
    
  //GPIO_InitTypeDef GPIO_InitStructure;
  GPIO_StructInit(&GPIO_InitStructure);
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_13 | GPIO_Pin_14 | GPIO_Pin_15;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(GPIOB, &GPIO_InitStructure);
    
  GPIO_PinAFConfig(GPIOB, 13, GPIO_AF_5);
  GPIO_PinAFConfig(GPIOB, 14, GPIO_AF_5);
  GPIO_PinAFConfig(GPIOB, 15, GPIO_AF_5);
    
  /* ^^^^^^^^^^^ pin initialization for the LCD goes here ^^^^^^^^^^ */
  GPIO_StructInit(&GPIO_InitStructure);
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(GPIOB, &GPIO_InitStructure);
    
  // Section 4.1 SPI2 configuration
  // Note: you will need to add some code in the last three functions
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_SPI2 , ENABLE);
  SPI_InitTypeDef SPI_InitStructure;
  SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
  SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
  SPI_InitStructure.SPI_CPOL = SPI_CPOL_Low;
  SPI_InitStructure.SPI_CPHA = SPI_CPHA_1Edge;
  SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
  SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_8;
  SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
  SPI_InitStructure.SPI_CRCPolynomial = 7;
  SPI_InitStructure.SPI_Mode = SPI_Mode_Master;
  SPI_Init(SPI2, &SPI_InitStructure);
  SPI_RxFIFOThresholdConfig(SPI2, SPI_RxFIFOThreshold_QF);
  SPI_Cmd(SPI2, ENABLE);
    
} 

static const struct lcd_cmdBuf initializers[] = {
  // SWRESET Software reset
  { 0x01, 150, 0, 0},
  // SLPOUT Leave sleep mode
  { 0x11, 150, 0, 0},
  // FRMCTR1, FRMCTR2 Frame Rate configuration -- Normal mode, idle
  // frame rate = fosc / (1 x 2 + 40) * (LINE + 2C + 2D)
  { 0xB1, 0, 3, { 0x01, 0x2C, 0x2D }},
  { 0xB2, 0, 3, { 0x01, 0x2C, 0x2D }},
  // FRMCTR3 Frame Rate configureation -- partial mode
  { 0xB3, 0, 6, { 0x01, 0x2C, 0x2D, 0x01, 0x2C, 0x2D }},
  // INVCTR Display inversion (no inversion)
  { 0xB4, 0, 1, { 0x07 }},
  /* ... */
  /*! llcmdstop2 !*/
  /*! llcmdstart3 !*/
  // PWCTR1 Power control -4.6V, Auto mode
  { 0xC0, 0, 3, { 0xA2, 0x02, 0x84}},
  // PWCTR2 Power control VGH25 2.4C, VGSEL -10, VGH = 3 * AVDD
  { 0xC1, 0, 1, { 0xC5}},
  // PWCTR3 Power control, opamp current smal, boost frequency
  { 0xC2, 0, 2, { 0x0A, 0x00 }},
  // PWCTR4 Power control, BLK/2, opamp current small and medium low
  { 0xC3, 0, 2, { 0x8A, 0x2A}},
  // PWRCTR5, VMCTR1 Power control
  { 0xC4, 0, 2, { 0x8A, 0xEE}},
  { 0xC5, 0, 1, { 0x0E }},
  // INVOFF Don't invert display
  { 0x20, 0, 0, 0},
  // Memory access directions. row address/col address, bottom to top refesh (10.1.27)
  { ST7735_MADCTL, 0, 1, {MADVAL(MADCTLGRAPHICS)}},
  // Color mode 16 bit (10.1.30
  { ST7735_COLMOD, 0, 1, {0x05}},
  // Column address set 0..127
  { ST7735_CASET, 0, 4, {0x00, 0x00, 0x00, 0x7F }},
  // Row address set 0..159
  { ST7735_RASET, 0, 4, {0x00, 0x00, 0x00, 0x9F }},
  // GMCTRP1 Gamma correction
  { 0xE0, 0, 16, {0x02, 0x1C, 0x07, 0x12, 0x37, 0x32, 0x29, 0x2D,
		  0x29, 0x25, 0x2B, 0x39, 0x00, 0x01, 0x03, 0x10 }},
  // GMCTRP2 Gamma Polarity corrction
  { 0xE1, 0, 16, {0x03, 0x1d, 0x07, 0x06, 0x2E, 0x2C, 0x29, 0x2D,
		  0x2E, 0x2E, 0x37, 0x3F, 0x00, 0x00, 0x02, 0x10 }},
  // DISPON Display on
  { 0x29, 100, 0, 0},
  // NORON Normal on
  { 0x13, 10, 0, 0},
  // End
  { 0, 0, 0, 0}
};

void f3d_lcd_init(void) {
  printf("LCD init...\n");
  const struct lcd_cmdBuf *cmd;
    
  f3d_lcd_sd_interface_init();    // Setup SPI2 Link and configure GPIO pins
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_DMA1, ENABLE);
  LCD_BKL_ON();                   // Enable Backlight
    
  // Make sure that the chip select and reset lines are deasserted
  LCD_CS_DEASSERT();              // Deassert Chip Select
    
  LCD_RESET_DEASSERT();
  delay(100);
  LCD_RESET_ASSERT();
  delay(100);
  LCD_RESET_DEASSERT();
  delay(100);
    
  // Write initialization sequence to the lcd
  for (cmd=initializers; cmd->command; cmd++) {
    LcdWrite(LCD_C,&(cmd->command),1);
    if (cmd->len)
      LcdWrite(LCD_D,cmd->data,cmd->len);
    if (cmd->delay) {
      delay(cmd->delay);
    }
  }
  printf("LCD init successful...\n");
}

static void LcdWrite(char dc,const char *data,int nbytes) {
  GPIO_WriteBit(LCD_PORT,GPIO_PIN_DC,dc); // dc 1 = data , 0 = control
  GPIO_ResetBits(LCD_PORT,GPIO_PIN_SCE);
  spiReadWrite(SPILCD,0,data,nbytes,LCDSPEED);
  GPIO_SetBits(LCD_PORT,GPIO_PIN_SCE);
}

static void LcdWrite16(char dc,const uint16_t *data,int cnt) {
  GPIO_WriteBit(LCD_PORT,GPIO_PIN_DC,dc);
  GPIO_ResetBits(LCD_PORT,GPIO_PIN_SCE);
  spiReadWrite16(SPILCD,0,data,cnt,LCDSPEED);
  GPIO_SetBits(LCD_PORT,GPIO_PIN_SCE);
}

static int xchng_datablock(SPI_TypeDef *SPIx, int half, const void *tbuf, void *rbuf, unsigned count) {
  DMA_InitTypeDef DMA_InitStructure;
  uint16_t dummy[] = {0xffff};

  DMA_Channel_TypeDef *rxChan;
  DMA_Channel_TypeDef *txChan;
  uint32_t dmaflag;

  if (count & 1)
    return -1;

  if (SPIx == SPI1) {
    rxChan = DMA1_Channel2;
    txChan = DMA1_Channel3;
    dmaflag = DMA1_FLAG_TC2;
  }
  else if (SPIx == SPI2) {
    rxChan = DMA1_Channel4;
    txChan = DMA1_Channel5;
    dmaflag = DMA1_FLAG_TC4;
  }
  else
    return -1;

  DMA_InitStructure.DMA_PeripheralBaseAddr = (uint32_t)(&(SPIx->DR));
  if (half) {
    DMA_InitStructure.DMA_PeripheralDataSize = DMA_PeripheralDataSize_HalfWord;
    DMA_InitStructure.DMA_MemoryDataSize = DMA_MemoryDataSize_HalfWord;
  }
  else {
    DMA_InitStructure.DMA_PeripheralDataSize = DMA_PeripheralDataSize_Byte;
    DMA_InitStructure.DMA_MemoryDataSize = DMA_MemoryDataSize_Byte;
  }
  DMA_InitStructure.DMA_PeripheralInc = DMA_PeripheralInc_Disable;
  DMA_InitStructure.DMA_BufferSize = count;
  DMA_InitStructure.DMA_Mode = DMA_Mode_Normal;
  DMA_InitStructure.DMA_Priority = DMA_Priority_VeryHigh;
  DMA_InitStructure.DMA_M2M = DMA_M2M_Disable;

  DMA_DeInit(rxChan);
  DMA_DeInit(txChan);

  if (rbuf) {
    DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t)rbuf;
    DMA_InitStructure.DMA_MemoryInc = DMA_MemoryInc_Enable;
  }
  else {
    DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t) dummy;
    DMA_InitStructure.DMA_MemoryInc = DMA_MemoryInc_Disable;
  }
  DMA_InitStructure.DMA_DIR = DMA_DIR_PeripheralSRC;
  DMA_Init(rxChan, &DMA_InitStructure);

  if (tbuf) {
    DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t)tbuf;
    DMA_InitStructure.DMA_MemoryInc = DMA_MemoryInc_Enable;
  }
  else {
    DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t) dummy;
    DMA_InitStructure.DMA_MemoryInc = DMA_MemoryInc_Disable;
  }
  DMA_InitStructure.DMA_DIR = DMA_DIR_PeripheralDST;
  DMA_Init(txChan, &DMA_InitStructure);

  // Enable channels
  DMA_Cmd(rxChan, ENABLE);
  DMA_Cmd(txChan, ENABLE);

  // Enable SPI TX/RX request
  SPI_I2S_DMACmd(SPIx, SPI_I2S_DMAReq_Rx | SPI_I2S_DMAReq_Tx, ENABLE);

  // Wait for completion
  while (DMA_GetFlagStatus(dmaflag) == RESET) { ; }

  // Disable channels
  DMA_Cmd(rxChan, DISABLE);
  DMA_Cmd(txChan, DISABLE);
  SPI_I2S_DMACmd(SPIx, SPI_I2S_DMAReq_Rx | SPI_I2S_DMAReq_Tx, DISABLE);
  return count;
}

int spiReadWrite(SPI_TypeDef *SPIx, uint8_t *rbuf, const uint8_t *tbuf, int cnt, uint16_t speed) {
  int i;
  SPIx->CR1 = (SPIx->CR1 & ~SPI_BaudRatePrescaler_256) | speed;

  if ((cnt > 4) && !(cnt & 1)) {
    return xchng_datablock(SPIx, 0, tbuf, rbuf , cnt);
  }
  else {
    for (i = 0; i < cnt; i++){
      SPI_SendData8(SPIx, tbuf ? *tbuf++ : 0xff);
      while (SPI_I2S_GetFlagStatus(SPIx, SPI_I2S_FLAG_RXNE) == RESET);
      if (rbuf) {
	*rbuf++ = SPI_ReceiveData8(SPIx);
      } else  {
	SPI_ReceiveData8(SPIx);
      }
    }
    return i;
  }
}

int spiReadWrite16(SPI_TypeDef *SPIx, uint16_t *rbuf, const uint16_t *tbuf, int cnt, uint16_t speed) {
  int i;
  SPIx->CR1 = (SPIx->CR1 & ~SPI_BaudRatePrescaler_256) | speed;
  SPI_DataSizeConfig(SPIx, SPI_DataSize_16b);
  if ((cnt > 4) && !(cnt & 3)) {
    i =  xchng_datablock(SPIx, 1, tbuf, rbuf , cnt);
  }
  else {
    for (i = 0; i < cnt; i++){
      SPI_I2S_SendData16(SPIx, tbuf ? *tbuf++ : 0xffff);
      while (SPI_I2S_GetFlagStatus(SPIx, SPI_I2S_FLAG_RXNE) == RESET);
      if (rbuf) {
	*rbuf++ = SPI_I2S_ReceiveData16(SPIx);
      } else {
	SPI_I2S_ReceiveData16(SPIx);
      }
    }
  }
  SPI_DataSizeConfig(SPIx, SPI_DataSize_8b);
  return i;
}

void f3d_lcd_setAddrWindow ( uint16_t x0 , uint16_t y0 , uint16_t x1 , uint16_t y1 , uint8_t madctl) {
  madctl = MADVAL ( madctl );
  if ( madctl != madctlcurrent ){
    f3d_lcd_writeCmd(ST7735_MADCTL);
    LcdWrite(LCD_D, &madctl, 1);
    madctlcurrent = madctl ;
  }
  f3d_lcd_writeCmd(ST7735_CASET);
  LcdWrite16(LCD_D,&x0,1);
  LcdWrite16(LCD_D,&x1,1);
  f3d_lcd_writeCmd(ST7735_RASET);
  LcdWrite16(LCD_D,&y0,1);
  LcdWrite16(LCD_D,&y1,1);
  f3d_lcd_writeCmd(ST7735_RAMWR);
}

void f3d_lcd_pushColor(uint16_t *color,int cnt) {
  LcdWrite16(LCD_D,color,cnt);
}

static void f3d_lcd_writeCmd(uint8_t c) {
  LcdWrite(LCD_C,&c,1);
}

void f3d_lcd_fillScreen(uint16_t color) {
  uint8_t y;
  uint16_t x[ST7735_width];
  for (y = 0; y < ST7735_width; y++) x[y] = color;
  f3d_lcd_setAddrWindow (0,0,ST7735_width-1,ST7735_height-1,MADCTLGRAPHICS);
  for (y=0;y<ST7735_height; y++) {
    f3d_lcd_pushColor(x,ST7735_width);
  }
}

/**
 * Fills screen from (xCoord, yCoord) to (ST7735_width-1, ST7735_height-1)
 */
void f3d_lcd_fillScreenXY(int xCoord, int yCoord, uint16_t color) {
  uint8_t y;
  uint16_t x[ST7735_width];
  for (y = 0; y < ST7735_width; y++) x[y] = color;
  f3d_lcd_setAddrWindow(xCoord, yCoord, ST7735_width-1, ST7735_height-1,MADCTLGRAPHICS);
  for (y = 0; y < ST7735_height; y++) {
    f3d_lcd_pushColor(x,ST7735_width);
  }
}

/**
 * Fills screen from (xCoord, yCoord) to (xCoord2, yCoord2)
 */
void f3d_lcd_fillScreenXYXY(int xCoord, int yCoord, int xCoord2, int yCoord2, uint16_t color) {
  uint8_t y;
  uint16_t x[ST7735_width];
  for (y = 0; y < ST7735_width; y++) x[y] = color;
  f3d_lcd_setAddrWindow(xCoord, yCoord, xCoord2, yCoord2, MADCTLGRAPHICS);
  for (y = 0; y < ST7735_height; y++) {
    f3d_lcd_pushColor(x,ST7735_width);
  }
}

void f3d_lcd_drawPixel(uint8_t x, uint8_t y, uint16_t color) {
  if ((x >= ST7735_width) || (y >= ST7735_height)) return;
  f3d_lcd_setAddrWindow(x,y,x+1,y+1,MADCTLGRAPHICS);
  f3d_lcd_pushColor(&color,1);
}

void f3d_lcd_drawChar(uint8_t x, uint8_t y, unsigned char c, uint16_t color, uint16_t background_color) {
  int i, j;
  for (i = 0; i < 5; i++) {
    for (j = 0; j < 8; j++){
      f3d_lcd_drawPixel(x+i,y+j, background_color);
    }
  }
  for (i = 0; i < 5; i++) {
    uint8_t byte = ASCII[c*5 + i];
    for (j = 0; j < 8; j++){
      if (byte & (1)) {
	f3d_lcd_drawPixel(x+i,y+j, color);
      }
      byte >>= 1;
    }
  }
}

void f3d_lcd_drawString(uint8_t x, uint8_t y, char *c, uint16_t color, uint16_t background_color) {
  while (c && *c) {
    f3d_lcd_drawChar(x, y, *c++, color, background_color);
    x += 6;
    if (x + 5 >= ST7735_width) {
      y += 10;
      x = 0;
    }
  }
}

/*
 * Draws bar Blocks from Lab 6
 */
void f3d_lcd_drawBarBlocks(uint8_t x, int height, uint16_t color) {
  if( height > 60) {
    height = 60;
  } else if(height < -60) {
    height = -60;
  }
    
  int i;
  uint16_t xArray[30];
    
  // set array colors
  for(i = 0; i < 30; i++) {
    xArray[i] = color;
  }
    
  if (height == 0) {
    return;
  } else if(height > 0) {
    f3d_lcd_setAddrWindow(x,70-height, x + 29, 69, MADCTLGRAPHICS);
    for(i = 0; i < height; i++) {
      f3d_lcd_pushColor(xArray, 30);
    }
  } else {
    f3d_lcd_setAddrWindow(x,71, (x + 29),(70 +(-1*height)), MADCTLGRAPHICS);
    for(i = 0; i < (-1*height); i++) {
      f3d_lcd_pushColor(xArray, 30);
    }
  }
}

/**
 * SD Card functions - Lab 9
 */

void f3d_sd_die() {
  printf("Failed with rc=%u.\n", rc);
  while (1);
}

void f3d_sd_openFile(char string[]) {
  printf("\nOpen an existing file (%s).\n", string);
  rc = f_open(&Fil, string, FA_READ);
    
  if (rc) {
    f3d_sd_die(rc);
  }
}

void f3d_sd_typeFileContents() {
  printf("\nType the file content.\n");
  for (;;) {
    rc = f_read(&Fil, Buff, sizeof Buff, &br);	/* Read a chunk of file */
    if (rc || !br) break;			        /* Error or end of file */
    int i;
    for (i = 0; i < br; i++)		        /* Type the data */
      putchar(Buff[i]);
  }
  if (rc) f3d_sd_die(rc);
}

void f3d_sd_closeFile() {
  printf("\nClose the file.\n");
  rc = f_close(&Fil);
  if (rc) {
    f3d_sd_die(rc);
  }
}

void f3d_sd_openRootDir() {
  printf("\nOpen root directory.\n");
  rc = f_opendir(&dir, "");
  if (rc) f3d_sd_die(rc);
}

void f3d_sd_directoryListing() {
  printf("\nDirectory listing...\n");
  for (;;) {
    rc = f_readdir(&dir, &fno);		/* Read a directory item */
    if (rc || !fno.fname[0]) break;	/* Error or end of dir */
    if (fno.fattrib & AM_DIR) {
      printf("   <dir>  %s\n", fno.fname);
    } else {
      printf("%8lu  %s\n", fno.fsize, fno.fname);
    }
  }
  if (rc) f3d_sd_die(rc);
}

int f3d_sd_drawBMP() {
  printf("\nf3d_sd_drawBMP(%d, %d, %d)\n", code, redraw, orientation);

  if (redraw == 0) {
    return 0;
  }
    
  if (code == 0) {
    f3d_sd_openFile("flower.bmp");
  } else if (code == 1) {
    f3d_sd_openFile("star.bmp");
  } else if (code == 2) {
    f3d_sd_openFile("tire.bmp");
  }
    
  rc = f_read(&Fil, (void *) &magic, 2, &br);
  printf ("Magic %c%c\n", magic.magic[0], magic.magic[1]);
    
  rc = f_read(&Fil, (void *) &header , sizeof (header), &br);
  printf ("file size %d offset %d\n", header.filesz, header.bmp_offset);
    
  rc = f_read(&Fil, (void *) &info , sizeof (info), &br);
  printf ("Width %d Height %d, bitspp %d\n", info.width, info.height, info.bitspp);
    
  Fil.fptr = header.bmp_offset;
    
  int x, y, i;
  for (y = 0; y < 128; y++) {
    uint16_t pixelArray[128];

    if (f3d_lcd_nunchukDataUpdates()) {
      printf("Nunchuk terminating drawing of BMP...\n");
      delay(10);
      f3d_sd_closeFile();
      return 1;
    }

    /*
      if (f3d_lcd_accelDataUpdates()) {
      f3d_sd_closeFile();
      return 1;
      }
    */
    
    for (x = 0; x < 128; x++) {
      rc = f_read(&Fil, (void *) &pixel, sizeof (pixel), &br);
      int b = pixel.b >> 3;
      int g = pixel.g >> 2;
      int r = pixel.r >> 3;
      pixelArray[x] = b << 11 | g << 5 | r;
    }
      
    //printf("Setting address window\n");
    delay(10);
    f3d_lcd_setAddrWindow(0, y, ST7735_width - 1, y, orientation);
    //printf("Pushing colors...\n");
    delay(10);
    f3d_lcd_pushColor(pixelArray, ST7735_width);
  }
    
  f3d_sd_closeFile();
  return 0;
}

/*
 * r = 5, g = 5, b = 6 bits
 */
int f3d_sd_app(int type) {
  if (type) {
    f3d_init(0);
  }
    
  redraw = 1;
  code = 0;
  orientation = 0x2;
    
  int x = 0;
  int y = 0;
  int i = 0;
    
  f_mount(0, &Fatfs);		/* Register volume work area (never fails) */
    
  f3d_nunchuk_read(&nunData);
  f3d_accel_read(accel);
    
  pitch = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 0);
  roll = f3d_accel_calcTiltAngle(accel[0], accel[1], accel[2], 1);
    
  prevPitch = pitch;
  prevRoll = roll;
    
  f3d_lcd_fillScreen(BLACK);
    
  //f3d_lcd_drawString(5, 1, "SD Card Pictures", BLACK, BLACK);
    
  delay(200);
    
  /*
   * Initial Test
   */
  printf("Starting initial test...\n");
  f3d_sd_openFile("message.txt");
  f3d_sd_typeFileContents();
  f3d_sd_closeFile();
  f3d_sd_openRootDir();
  f3d_sd_directoryListing();
  printf("Initial test complete...\n");
    
  while(1) {
    /*
     * Initial checks at start of every loop to update data
     */
    f3d_lcd_nunchukDataUpdates();
    f3d_lcd_accelDataUpdates();
        
    /*
     * Logic needs to go here
     */
    redraw = f3d_sd_drawBMP();
  }
}

int f3d_lcd_gameMenu(void) {
  int stars[128];
  int i = 0;
  int value = 159;
  int valueIteration = 159;
    
  for (i = 0; i < 128; i++) {
    stars[i] = value;
    value -= 10;
        
    if (value < 0) {
      value = valueIteration - 1;
      valueIteration = value;
    }
  }
    
  i = 0;
    
  f3d_lcd_fillScreen(BLACK);
    
  /*
   * At this point the screen should sort of look like moving stars
   */
  while (1) {
    f3d_lcd_drawPixel(i, stars[i], BLACK);
    stars[i] = stars[i] - 1;
        
    if (stars[i] < 0) {
      stars[i] = 159;
    }
        
    f3d_lcd_drawPixel(i, stars[i], WHITE);
        
    i++;
  }
}

/* f3d_lcd_sd.c ends here */
