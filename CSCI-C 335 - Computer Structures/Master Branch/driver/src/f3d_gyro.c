/* f3d_gyro.c --- 
 * 
 * Filename: f3d_gyro.c
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: Matthew Lonis
 * Created: Thu Oct 31 09:10:53 2013
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

#include <f3d_accel.h>
#include <f3d_delay.h>
#include <f3d_gyro.h>
#include <f3d_i2c.h>
#include <f3d_init.h>
#include <f3d_lcd_sd.h>
#include <f3d_led.h>
#include <f3d_mag.h>
#include <f3d_nunchuk.h>
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <glcdfont.h>
#include <stm32f30x.h>
#include <stdio.h>
#include <math.h>

void f3d_gyro_interface_init() {
  /**********************************************************************/
  /************** CODE HERE *********************************************/

  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA, ENABLE);
  
  GPIO_InitTypeDef GPIO_InitStructure1;
  GPIO_StructInit(&GPIO_InitStructure1);
  GPIO_InitStructure1.GPIO_Pin = GPIO_Pin_5 | GPIO_Pin_6 | GPIO_Pin_7;
  GPIO_InitStructure1.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure1.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure1.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure1.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(GPIOA, &GPIO_InitStructure1);
  
  GPIO_PinAFConfig(GPIOA, 5, GPIO_AF_5);
  GPIO_PinAFConfig(GPIOA, 6, GPIO_AF_5);
  GPIO_PinAFConfig(GPIOA, 7, GPIO_AF_5);

  //You must configure and initialize the following 4 pins

  //SCK PA5 
  
  //MOSI PA6 
  
  //MISO PA7

  //CS PE3

  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOE, ENABLE);
  GPIO_InitTypeDef GPIO_InitStructure;
  GPIO_StructInit(&GPIO_InitStructure);
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_3;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  
  GPIO_Init(GPIOE, &GPIO_InitStructure);
  
  //set the CS high

  GPIO_SetBits(GPIOE, GPIO_Pin_3);
  
  /**********************************************************************/
   
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_SPI1, ENABLE);
  //SPI Initialization and configuration
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
  SPI_Init(SPI1, &SPI_InitStructure);
  SPI_RxFIFOThresholdConfig(SPI1, SPI_RxFIFOThreshold_QF);
  SPI_Cmd(SPI1, ENABLE);
}

//the init function to be called in your main.c
void f3d_gyro_init(void) {
  //
  //SETTING THE CONTROL REGISTERS 
  f3d_gyro_interface_init();
  // CTRL1 Register 
  // Bit 7:6 Data Rate: Datarate 0
  // Bit 5:4 Bandwidth: Bandwidth 3
  // Bit 3: Power Mode: Active
  // Bit 2:0 Axes Enable: X,Y,Z enabled
  uint8_t ctrl1;
  uint8_t ctrl4;
	
  ctrl1 |= (uint8_t) (((uint8_t)0x00)|		
		      ((uint8_t)0x30)|		
		      ((uint8_t)0x08)|		
		      ((uint8_t)0x07));
  // CTRL4 Register 
  // Bit 7 Block Update: Continuous */
  // Bit 6 Endianess: LSB first  */
  // Bit 5:4 Full Scale: 500 dps */
  ctrl4 |= (uint8_t) (((uint8_t)0x00)|			
		      ((uint8_t)0x00)|				     
		      ((uint8_t)0x10));

  f3d_gyro_write(&ctrl1, 0x20, 1);
  f3d_gyro_write(&ctrl4, 0x23, 1);

}
//to read from it
void f3d_gyro_read(uint8_t* pBuffer, uint8_t ReadAddr, uint16_t NumByteToRead) {
  //are we reading one byte or more than one byte???
  if (NumByteToRead > 1) {
    ReadAddr |= (uint8_t)(0x80 | 0x40); // sets to multibyte mode
  } else {
    ReadAddr |= (uint8_t) (0x80); // sets to read mode (first bit 1)
  }

  //setting chip select to low (LETS TALK!)
  GYRO_CS_LOW();

  //sending address byte
  f3d_gyro_sendbyte(ReadAddr); 
 
  while(NumByteToRead > 0x00) {
    //WE are now sending dummy data so we can read the valuable!
    //remember we must write to read!
    //putting the information in the buffer
    *pBuffer = f3d_gyro_sendbyte(((uint8_t)0x00));
    NumByteToRead--;
    pBuffer++;
  }

  //setting chip select to high (DONE TALKING)
  GYRO_CS_HIGH();//setting chip select to high (DONE TALKING)
}

/*writing function*/
void f3d_gyro_write(uint8_t* pBuffer, uint8_t WriteAddr, uint16_t NumByteToWrite) {
  /****************************************************************************/
  /************** CODE HERE *********************************************/

  //CHECK TO SEE HOW MANY BYTES AND HANDLE THAT CORRECTLY
  if (NumByteToWrite > 1) {
    WriteAddr |= (uint8_t)(0x40);
  }
  //SET THE CS
  GYRO_CS_LOW();
  //SEND THE FIRST BYTE
  f3d_gyro_sendbyte(WriteAddr);  
  while(NumByteToWrite > 0x00) {
    //WE are now sending dummy data so we can read the valuable!
    //remember we must write to read!
    //putting the information in the buffer
    f3d_gyro_sendbyte(*pBuffer);
    NumByteToWrite--;
    pBuffer++;
  }
  //IF MULTIPLE, SEND THE ADDITIONAL

  //Set THE CS
  GYRO_CS_HIGH();
  /***************************************************************************/
}

/*sends the bytes*/
static uint8_t f3d_gyro_sendbyte(uint8_t byte) {
  /*********************************************************/
  /***********************CODE HERE ************************/

  while (SPI_I2S_GetFlagStatus(SPI1, SPI_I2S_FLAG_TXE) == RESET);
  SPI_SendData8(SPI1, byte);

  while (SPI_I2S_GetFlagStatus(SPI1, SPI_I2S_FLAG_RXNE) == RESET);
  return (uint8_t)SPI_ReceiveData8(SPI1);

  /********************** CODE HERE ************************/
  /*********************************************************/
}
/*gets the data*/
void f3d_gyro_getdata(float *pfData) {
  //
  //
  int16_t RawData[3];
  uint8_t tmpbuffer[6];
  int i;
  //We are going to write some data to the gyro
  f3d_gyro_write(tmpbuffer,0x28,6);
  //Then we are going to read it
  f3d_gyro_read(tmpbuffer,0x28,6);
  //casting the data retreiving from tmpbuffer to raw data
  for(i=0; i<3; i++) {
    RawData[i]=(int16_t)(((uint16_t)tmpbuffer[2*i+1] << 8) + tmpbuffer[2*i]);
  }
  //adjusting the data with the sensitivity
  for(i=0; i<3; i++) {
    pfData[i]=(float)RawData[i]/L3G_Sensitivity_500dps;
  }
}

/*
 * Gyro app from Lab 5
 *
 * @param init  If init = 1, hardware needs initialized, otherwise nothing.
 */
int f3d_gyro_app(int init) {
    if (init) {
        f3d_init(0);
    }

    nunchuk_t nunData;
    unsigned char jx;
    unsigned char c;
    unsigned char z;
    f3d_nunchuk_read(&nunData);
    jx = nunData.jx;
    c = nunData.c;
    z = nunData.z;
    int prevValue[3] = { -255, -255, -255};
    
    //draw lines
    int y;
    
    f3d_lcd_fillScreen(CYAN);
    
    // x y and z axis labels
    f3d_lcd_drawChar(17, 150, 120, BLACK, CYAN);
    f3d_lcd_drawChar(55, 150, 121, BLACK, CYAN);
    f3d_lcd_drawChar(92, 150, 122, BLACK, CYAN);
    
    while(y++ < 128) {
        f3d_lcd_drawPixel(y, 137, BLACK); // line above velocities
        //f3d_lcd_drawPixel(y, 70, BLACK); // 0 velocity graph axis
    }
    
    f3d_lcd_drawString(1, 67, "0", BLACK, CYAN);
    int q = 8;
    
    while (q < 128) {
        f3d_lcd_drawPixel(q++, 70, BLACK);
    }
    
    float velos[3];

    delay(250);
    
    while(1) {
        if (user_btn_read()) {
            return 1;
        }

	f3d_nunchuk_read(&nunData);
	jx = nunData.jx;
	c = nunData.c;
	z = nunData.z;
	
	if (c == 1) {
	  return 1;
	} else if (z == 1) {
	  return -1;
	}
	
	if (jx > 200) {
	  return 1;
	} else if (jx < 55) {
	  return -1;
	}
        
        f3d_gyro_getdata(velos);
	int temp[3] = {(int) ceil(velos[0]), (int) ceil(velos[1]), (int)ceil(velos[2])};
	
	if ((temp[0] - prevValue[0]) > 1 || (temp[0] - prevValue[0]) < -1 || (temp[1] - prevValue[1]) > 1 || (temp[1] - prevValue[1]) < -1 || (temp[2] - prevValue[2]) > 1 || (temp[2] - prevValue[2]) < -1) {
	  f3d_lcd_drawBarBlocks(15, prevValue[0],CYAN);
	  f3d_lcd_drawBarBlocks(55, prevValue[1], CYAN);
	  f3d_lcd_drawBarBlocks(95, prevValue[2], CYAN);

	  char str[20];
	  snprintf(str, sizeof(float) * 22, "%5.1f %5.1f %5.1f", velos[0], velos[1], velos[2]);
	  f3d_lcd_drawString(2, 140, str, BLACK, CYAN);
	  
	  //draw graphs
	  
	  uint16_t colors[3];
	  int i;
	  
	  for(i = 0; i < 3; i++) {
            if(temp[i] >= 0) {
	      colors[i] = GREEN;
            }
            else {
	      colors[i] = RED;
            }
	  }
	  
	  f3d_lcd_drawBarBlocks(15, temp[0], colors[0]);
	  f3d_lcd_drawBarBlocks(55, temp[1], colors[1]);
	  f3d_lcd_drawBarBlocks(95, temp[2], colors[2]);
	  
	  delay(30);

	  for (i = 0; i < 3; i++) {
	    prevValue[i] = temp[i];
	  }
	}
    }
}

/* f3d_gyro.c ends here */
