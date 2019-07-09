all: test.s

test.s: test.c
	$(CC) $(CFLAGS) -S $< -o $@

include ../Makefile.common

clean:
	rm test.s

