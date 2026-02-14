CC = gcc
CFLAGS = -Wall -Wextra
GENFILE = gen_main.c
META = ./meta.sh -o $(GENFILE)

main: main.c
	$(META) && $(CC) $(CFLAGS) $(GENFILE) -o main

clean:
	rm -f main $(GENFILE)
