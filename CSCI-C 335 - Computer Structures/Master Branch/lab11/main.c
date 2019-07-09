/* main.c --- 
 * 
 * Filename: main.c
 * Description: 
 * Author: 
 * Maintainer: 
 * Created: Thu Jan 10 11:23:43 2013
 * Last-Updated: 
 *           By: 
 *     Update #: 0
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
 * 
 */
/* Code: */

#include <stm32f30x.h> // Pull in include files for F30x standard drivers 
#include <f3d_led.h> // Pull in include file for the local drivers
#include <f3d_uart.h>
#include <f3d_gyro.h>
#include <f3d_lcd_sd.h>
#include <f3d_i2c.h>
#include <f3d_accel.h>
#include <f3d_mag.h>
#include <f3d_nunchuk.h>
#include <f3d_rtc.h>
#include <f3d_systick.h>
#include <f3d_timer2.h>
#include <f3d_dac.h>
#include <f3d_systick.h>
#include <ff.h>
#include <diskio.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "queue.h"

#define TIMER 20000
#define AUDIOBUFSIZE 128
#define RIFF 'FFIR'
#define WAVE 'EVAW'
#define fmt ' tmf'
#define data 'atad'

extern uint8_t Audiobuf[];
extern int audioplayerHalf;
extern int audioplayerWhole;

FATFS Fatfs;		/* File system object */
FIL fid;		/* File object */
BYTE Buff[512];		/* File read buffer */
int ret;

struct ckhd {
  uint32_t ckID;
  uint32_t cksize;
};

struct fmtck {
  uint16_t wFormatTag;      
  uint16_t nChannels;
  uint32_t nSamplesPerSec;
  uint32_t nAvgBytesPerSec;
  uint16_t nBlockAlign;
  uint16_t wBitsPerSample;
};

void readckhd(FIL *fid, struct ckhd *hd, uint32_t ckID) {
  f_read(fid, hd, sizeof(struct ckhd), &ret);
  if (ret != sizeof(struct ckhd))
    exit(-1);
  if (ckID && (ckID != hd->ckID))
    exit(-1);
}

void die (FRESULT rc) {
  printf("Failed with rc=%u.\n", rc);
  while (1);
}

int count = 0;
nunchuk_t nunData;

int main(void) { 
  FRESULT rc = 0;			/* Result code */
  DIR dir;			/* Directory object */
  FILINFO fno;			/* File information object */
  UINT bw, br;
  unsigned int retval;
  int bytesread;
  struct ckhd hd;
  uint32_t  waveid;
  struct fmtck fck;
  TCHAR var;
  
  setvbuf(stdin, NULL, _IONBF, 0);
  setvbuf(stdout, NULL, _IONBF, 0);
  setvbuf(stderr, NULL, _IONBF, 0);
  
  f3d_init(0);
  printf("Reset\n");
  
  f_mount(0, &Fatfs);/* Register volume work area */
  printf("Work area registered...\n");
  
  while(1){
    f3d_nunchuk_read(&nunData);
    f3d_lcd_fillScreen(RED);
    int background = RED;
    int foreground = BLACK;
    int select = WHITE;
    
    if (nunData.jx > 200) {
      count++;
      rc = f_close(&fid);
      delay(500);
    } else if (nunData.jx < 50) {
      count--;
      rc = f_close(&fid);
      delay(500);
    } 
    
    if (count < 0) {
      count = 2;
    } else if (count > 2) {
      count = 0;
    }
    
    if (count == 0) {
      printf("Opening thermo.wav...\n");
      f3d_lcd_drawString(10, 1, "thermo", select, background);
      rc = f_open(&fid, "thermo.wav", FA_READ);
    } else {
      f3d_lcd_drawString(10, 1, "thermo", foreground, background);
    }

    if (count == 1) {
      printf("Opening makemyday.wav...\n");
      f3d_lcd_drawString(10, 20, "eastwood", select, background);
      rc = f_open(&fid, "makemyday.wav", FA_READ);
    } else {
      f3d_lcd_drawString(10, 20, "eastwood", foreground, background);
    }

    if (count == 2) {
      printf("Opening holyhole.wav...\n");
      f3d_lcd_drawString(10, 40, "batman", select, background);
      rc = f_open(&fid, "holyhole.wav", FA_READ);
    } else {
      f3d_lcd_drawString(10, 40, "batman", foreground, background);
    }

    printf("rc = %d...\n", rc);
    
    if (!rc) {
      readckhd(&fid, &hd, 'FFIR');
    
      f_read(&fid, &waveid, sizeof(waveid), &ret);
      
      if ((ret != sizeof(waveid)) || (waveid != 'EVAW')) {
	return -1;
      }
    
      readckhd(&fid, &hd, ' tmf');
    
      f_read(&fid, &fck, sizeof(fck), &ret);
    
      // skip over extra info
    
      if (hd.cksize != 16) {
	printf("extra header info %d\n", hd.cksize - 16);
	f_lseek(&fid, hd.cksize - 16);
      }
    
      printf("audio format 0x%x\n", fck.wFormatTag);
      printf("channels %d\n", fck.nChannels);
      printf("sample rate %d\n", fck.nSamplesPerSec);
      printf("data rate %d\n", fck.nAvgBytesPerSec);
      printf("block alignment %d\n", fck.nBlockAlign);
      printf("bits per sample %d\n", fck.wBitsPerSample);
    
      // now skip all non-data chunks !
    
      while(1){
	readckhd(&fid, &hd, 0);
	if (hd.ckID == 'atad')
	  break;
	f_lseek(&fid, hd.cksize);
      }
    
      printf("Samples %d\n", hd.cksize);
    
      // Play it !
    
      //audioplayerInit(fck.nSamplesPerSec);
      f3d_timer2_enable(fck.nSamplesPerSec);

      f_read(&fid, Audiobuf, AUDIOBUFSIZE, &ret);

      hd.cksize -= ret;

      audioplayerStart();

      while (hd.cksize) {

	int next = hd.cksize > AUDIOBUFSIZE/2 ? AUDIOBUFSIZE/2 : hd.cksize;

	if (audioplayerHalf) {
	  if (next < AUDIOBUFSIZE/2) {
	    bzero(Audiobuf, AUDIOBUFSIZE/2);
	  }

	  f_read(&fid, Audiobuf, next, &ret);
	  hd.cksize -= ret;
	  audioplayerHalf = 0;
	}

	if (audioplayerWhole) {
	  if (next < AUDIOBUFSIZE/2) {
	    bzero(&Audiobuf[AUDIOBUFSIZE/2], AUDIOBUFSIZE/2);
	  }

	  f_read(&fid, &Audiobuf[AUDIOBUFSIZE/2], next, &ret);
	  hd.cksize -= ret;
	  audioplayerWhole = 0;
	}
      }

      //audioplayerStop();
    }

    audioplayerStop();
    
    printf("\nClose the file.\n"); 
    rc = f_close(&fid);

    if (!rc) {
      die(rc);
    }
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
