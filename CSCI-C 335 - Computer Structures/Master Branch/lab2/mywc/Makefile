CC = gcc
CFLAGS = -g
LDFLAGS = -g

OBJECTS = mywc.o

all: mywc

mywc: $(OBJECTS)
	$(CC) $(LDFLAGS) -o mywc $(OBJECTS)

mywc.o: mywc.c
	$(CC) $(CFLAGS) -c mywc.c

debug : mywc
	gdb --debugger gdb mywc

clean:
	rm -f mywc mywc.o
