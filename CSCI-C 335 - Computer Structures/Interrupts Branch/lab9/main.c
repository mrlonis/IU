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

#include <stm32f30x.h>  // Pull in include files for F30x standard drivers 
#include <f3d_accel.h>
#include <f3d_delay.h>
#include <f3d_gyro.h>
#include <f3d_i2c.h>
#include <f3d_lcd_sd.h>
#include <f3d_led.h>
#include <f3d_mag.h>
#include <f3d_nunchuk.h>
#include <f3d_rtc.h>
#include <f3d_uart.h>
#include <f3d_user_btn.h>
#include <diskio.h>
#include <stdio.h>
#include <ff.h>
#include "queue.h"

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

int nunchukDataUpdates(void);
int accelDataUpdates(void);
void sd_die();
void f3d_sd_openFile(char string[]);
void sd_typeFileContents();
void sd_closeFile();
void sd_openRootDir();
void sd_directoryListing();
int sd_app(int nunchuk1, int init);

int main(void) {
  sd_app(1, 1);
}

#ifdef USE_FULL_ASSERT
void assert_failed(uint8_t* file, uint32_t line) {
/* Infinite loop */
/* Use GDB to find out why we're here */
  while (1);
}
#endif

int nunchukDataUpdates(void) {
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

int accelDataUpdates(void) {
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

/**
 * SD Card functions - Lab 9
 */
void sd_die() {
  printf("Failed with rc=%u.\n", rc);
  while (1);
}

void sd_openFile(char string[]) {
  printf("\nOpen an existing file (%s).\n", string);
  rc = f_open(&Fil, string, FA_READ);
    
  if (rc) {
    sd_die(rc);
  }
}

void sd_typeFileContents() {
  printf("\nType the file content.\n");
  for (;;) {
    rc = f_read(&Fil, Buff, sizeof Buff, &br);	/* Read a chunk of file */
    if (rc || !br) break;			        /* Error or end of file */
    int i;
    for (i = 0; i < br; i++)		        /* Type the data */
      putchar(Buff[i]);
  }
  if (rc) sd_die(rc);
}

void sd_closeFile() {
  printf("\nClose the file.\n");
  rc = f_close(&Fil);
  if (rc) {
    sd_die(rc);
  }
}

void sd_openRootDir() {
  printf("\nOpen root directory.\n");
  rc = f_opendir(&dir, "");
  if (rc) sd_die(rc);
}

void sd_directoryListing() {
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
  if (rc) sd_die(rc);
}

int sd_drawBMP() {
  printf("\nsd_drawBMP(%d, %d, %d)\n", code, redraw, orientation);

  if (redraw == 0) {
    return 0;
  }
    
  if (code == 0) {
    sd_openFile("flower.bmp");
  } else if (code == 1) {
    sd_openFile("star.bmp");
  } else if (code == 2) {
    sd_openFile("tire.bmp");
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

    if (nunchukDataUpdates()) {
      printf("Nunchuk terminating drawing of BMP...\n");
      delay(10);
      sd_closeFile();
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
    
  sd_closeFile();
  return 0;
}

/*
 * r = 5, g = 5, b = 6 bits
 */
int sd_app(int nunchuk1, int init) {
  if (init) {
    f3d_init(nunchuk1, init);
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
  sd_openFile("message.txt");
  sd_typeFileContents();
  sd_closeFile();
  sd_openRootDir();
  sd_directoryListing();
  printf("Initial test complete...\n");
    
  while(1) {
    /*
     * Initial checks at start of every loop to update data
     */
    nunchukDataUpdates();
    accelDataUpdates();
        
    /*
     * Logic needs to go here
     */
    redraw = sd_drawBMP();
  }
}

/* main.c ends here */
