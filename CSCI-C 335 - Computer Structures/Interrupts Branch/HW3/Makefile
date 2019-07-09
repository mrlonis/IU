# Tools
CC = arm-none-eabi-gcc

DD = arm-none-eabi-gcc

LD = arm-none-eabi-gcc

OC = arm-none-eabi-objcopy

RM = rm

AS = arm-none-eabi-as

QEMU = qemu-system-arm

# Compilation Flags

QEMUFLAGS = -machine versatilepb -cpu cortex-m3 -nographic -monitor null -serial null -semihosting -kernel

CFLAGS = -g -O1 -mcpu=cortex-m0 -mthumb

ASFLAGS = -g -mcpu=cortex-m0 -mthumb

LDFLAGS = -g -mcpu=cortex-m0 -mthumb --specs=rdimon.specs -lc -lrdimon

# Objects

OBJS = hw3.o

# Build executable 

disassembler : hw3.o
	$(LD) $(LDFLAGS) -o disassembler hw3.o

generateCodes : generateCodes.o
	$(LD) $(LDFLAGS) -o generateCodes generateCodes.o

# compile and generate dependency info

hw3.o: hw3.c
	$(CC) -c $(CFLAGS) hw3.c -o hw3.o
	$(DD) -MM $(CFLAGS) hw3.c > hw3.d

generateCodes.o : generateCodes.c
	$(CC) -c $(CFLAGS) generateCodes.c -o generateCodes.o
	$(DD) -MM $(CFLAGS) generateCodes.c > generateCodes.d

clean:
	$(RM) -f *.o *.d *.bin *.hex *.out testOne.asm

debug: disassembler
	arm-none-eabi-gdb disassembler

all: disassembler generateCodes

#
# Generates codes.hex containing all possible values from 0x0000 to 0xffff
#
# Used in roundtrip testing
#
generateCodeFile: generateCodes
	export QEMU_AUDIO_DRV=wav
	$(QEMU) $(QEMUFLAGS) generateCodes > codes.hex

#
# This a roundtrip test. It uses codes.hex which contains every possible code.
# The program decodes these codes into assembly file called testOne.asm.
# This file is then assembled into a .bin and has the hex stripped out into
# testOne.hex. The files testOne.hex and codes.hex are then compared for similarity
#
testOne:
	make clean && make all && make generateCodeFile
	export QEMU_AUDIO_DRV=wav
	$(QEMU) $(QEMUFLAGS) disassembler < codes.hex > testOne.asm
	$(AS) $(ASFLAGS) testOne.asm -o testOne.o
	$(OC) testOne.o -O binary --only-section=.text testOne.bin
	hexdump -x testOne.bin |sed -e 's/^[^ ]*//' > testOne.hex
	diff codes.hex testOne.hex

#
# This tests my custom created assembly file test.asm and uses it's hex codes to
# run it against disassembler and see if my inputs agree with my outputs
#
testTwo:
	make clean && make all
	$(AS) $(ASFLAGS) test.asm -o test.o
	$(OC) test.o -O binary --only-section=.text test.bin
	hexdump -x test.bin |sed -e 's/^[^ ]*//' > test.hex
	export QEMU_AUDIO_DRV=wav
	$(QEMU) $(QEMUFLAGS) disassembler < test.hex > test.out
	diff test.out test.asm

test:
	make testOne && make testTwo
