/**
 * xsh_hello.c - xsh_hello
 *
 * Created By: Matthew Lonis
 * Created On: 11 January 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 15 January 2018
 */

/* xsh_hello.c - xsh_hello */

#include <xinu.h>
#include <string.h>
#include <stdio.h>

/*------------------------------------------------------------------------
 * xsh_hello - Prints a 'hello world' type message using the users input
 *------------------------------------------------------------------------
 */
shellcmd xsh_hello(int nargs, char *args[]) {
    /* Output info for '--help' argument */
    if (nargs == 2 && strncmp(args[1], "--help", 7) == 0) {
        printf("Usage: %s\n\n", args[0]);
        printf("Description:\n");
        printf("\tDisplays a typical 'Hello World' phrase using user input.\n");
        printf("Example:\n");
        printf("\tInput: 'Matthew'\n");
        printf("\tOutput: 'Hello Matthew, Welcome to the world of Xinu!!'\n\n");
        return 0;
    }
    
    /* Check argument count */
    if (nargs > 2) {
        fprintf(stderr, "%s: too many arguments\n", args[0]);
        fprintf(stderr, "Try '%s --help' for more information\n", args[0]);
        return 1;
    }
    
    /* Check argument count */
    if (nargs < 2) {
        fprintf(stderr, "%s: too few arguments\n", args[0]);
        fprintf(stderr, "Try '%s --help' for more information\n", args[0]);
        return 1;
    }
    
    /* Print Statement */
    if (nargs == 2) {
        printf("Hello %s, Welcome to the world of Xinu!!\n", args[1]);
    }
    
    return 0;
}

/* end of file */
