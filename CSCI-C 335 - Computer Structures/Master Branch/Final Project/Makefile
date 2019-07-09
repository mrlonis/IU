#
#
#

CC = gcc
CFLAGS = -g

game: main.o
	$(CC) $(CFLAGS) -o game main.o

main.o: main.c
	$(CC) -c $(CFLAGS) main.c -o main.o

clean: 
	rm *.o game

all: game

test:
	make clean && make all
	./game