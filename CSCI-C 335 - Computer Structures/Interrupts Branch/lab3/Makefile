#
# Makefile
#
# This file was copied from fall2017-lab/lab3
#

TEMPLATEROOT = ../fall2017-lab

# compilation flags for gdb

CFLAGS  = -O1 -g
ASFLAGS = -g

# object files

OBJS=  $(STARTUP) main.o f3d_led.o f3d_user_btn.o stm32f30x_rcc.o stm32f30x_gpio.o

# include common make file

vpath %.c .
include $(TEMPLATEROOT)/c335.mk
