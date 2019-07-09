#
# Makefile
#
# Created By: Matthew Lonis
# Created On: September 11th, 2017
# Last Modified By: Matthew Lonis
# Last Modified On: September 16th, 2017
# Part Of: HW1
#
# This Makefile was inspired by our lab template Makefile. 
# I initially tried to emulate the Makefile we used in lab3, 
# however I was unable to resolve getting the template lab 
# Makefile to compile and output everything I wanted, so I 
# made this file and ended up learning how to do this all 
# manually as well as understand the lab Makefile template.
#


OBJS = test.o t1.o

# Tool path

TOOLROOT = /l/arm2/devtools/bin/

# Tools

CC = $(TOOLROOT)/arm-none-eabi-gcc
GAS = $(TOOLROOT)/arm-none-eabi-gcc
DD = $(TOOLROOT)/arm-none-eabi-gcc
LD = $(TOOLROOT)/arm-none-eabi-gcc
OC = $(TOOLROOT)/arm-none-eabi-objcopy
GP = grep
RM = rm
GDB = $(TOOLROOT)/arm-none-eabi-gdb
AR = $(TOOLROOT)/arm-none-eabi-ar
AS = $(TOOLROOT)/arm-none-eabi-as
OBJCOPY = $(TOOLROOT)/arm-none-eabi-objcopy
QEMU = $(TOOLROOT)/qemu-system-arm
OBJDUMP = $(TOOLROOT)/arm-none-eabi-objdump

# Flags

CFLAGS = -g -O1 -mcpu=cortex-m0 -mthumb
LDFLAGS = -g -mcpu=cortex-m0 -mthumb --specs=rdimon.specs -lc -lrdimon
ASFLAGS = -g -mcpu=cortex-m0 -mthumb
QEMUFLAGS = -machine versatilepb -cpu cortex-m3 -nographic -monitor null -serial null -semihosting -kernel
OBJDUMPFLAGS = -D

# Build executable 

HW1.elf : $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

# compile and generate dependency info

test.s: test.c
	$(CC) -c $(CFLAGS) -S -o test.s test.c

test.o: test.c
	$(CC) -c $(CFLAGS) -o test.o test.c

t1.o: t1.s
	$(AS) -c $(ASFLAGS) -o t1.o t1.s

HW1.bin: HW1.elf
	$(OC) -O binary HW1.elf HW1.bin

clean:
	$(RM) -f $(OBJS) $(OBJS:.o=.d) HW1.elf HW1.bin output.txt test.s test.dump t1.dump

all: $(ELF) test.s

debug: HW1.elf
	($(GDB)) HW1.elf

all: HW1.elf test.s HW1.bin test.o t1.o

test: HW1.elf
	export QEMU_AUDIO_DRV=wav
	$(QEMU) $(QEMUFLAGS) HW1.elf > output.txt

dump: test.o
	$(OBJDUMP) $(OBJDUMPFLAGS) test.o > test.dump
	$(OBJDUMP) $(OBJDUMPFLAGS) t1.o > t1.dump
