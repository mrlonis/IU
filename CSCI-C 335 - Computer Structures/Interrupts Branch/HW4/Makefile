OBJS = main.o test_functions.o fib_c.o fib.o abs_c.o abs.o gcd_c.o gcd.o

ELF=$(notdir $(CURDIR)).elf
TOOLROOT=/l/arm2/devtools/bin

CC=$(TOOLROOT)/arm-none-eabi-gcc
LD=$(TOOLROOT)/arm-none-eabi-gcc
AR=$(TOOLROOT)/arm-none-eabi-ar
AS=$(TOOLROOT)/arm-none-eabi-as
GDB=$(TOOLROOT)/arm-none-eabi-gdb
QEMU=$(TOOLROOT)/qemu-system-arm
OBJDUMP=$(TOOLROOT)/arm-none-eabi-objdump

CFLAGS = -g -mcpu=cortex-m0 -mthumb -I..
LDFLAGS = --specs=rdimon.specs -lc -lrdimon

QFLAGS= -cpu cortex-m3 -nographic 
QFLAGS+= -monitor null -serial null 
QFLAGS+= -machine integratorcp -semihosting -kernel 

$(ELF) : $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $@

.s.o : 
	$(AS) $(CFLAGS) -g $< -o $@
	$(OBJDUMP) -d $@ > $(@:.o=.lst)

.c.o : 
	$(CC) $(CFLAGS) -c $< -o $@

test : $(ELF)
	$(QEMU) $(QFLAGS)  $<

debug: $(ELF)
	$(QEMU) $(QFLAGS)  $< -gdb tcp::51234 -S &
	$(GDB) $< --command=../main.gdb

clean: 
	rm -f $(OBJS) $(ELF) $(OBJS:.o=.lst)


