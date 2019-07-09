CC = gcc
CFLAGS = -g
LDFLAGS = -g

OBJECTS = rpn.o

all: rpn

rpn: $(OBJECTS)
	$(CC) $(LDFLAGS) -o rpn $(OBJECTS)

rpn.o: rpn.c
	$(CC) $(CFLAGS) -c rpn.c

debug : rpn
	gdb --debugger gdb rpn

clean:
	rm -f rpn rpn.o
