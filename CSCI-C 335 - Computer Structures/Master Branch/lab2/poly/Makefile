CC = gcc
CFLAGS = -g
LDFLAGS = -g

OBJECTS = poly.o dump.o

all: poly

poly: $(OBJECTS)
	$(CC) $(LDFLAGS) -o poly $(OBJECTS)

poly.o: poly.c
	$(CC) $(CFLAGS) -c poly.c

dump.o: dump.c
	$(CC) $(CFLAGS) -c dump.c

debug : poly
	gdb --debugger gdb poly

clean:
	rm -f poly poly.o dump.o
