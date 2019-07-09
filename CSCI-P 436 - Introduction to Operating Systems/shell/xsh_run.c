/**
 * xsh_run.c
 *
 * Part Of: Assignment 4 & 5
 *
 * Created By: Matthew Lonis
 * Created On: 25 February 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 4 April 2018
 */

/*
 * xsh_run.c - xsh_run
 */

/*
 * Include statements
 */
#include <xinu.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

/*
 * Function prototypes
 */
int ffib(int n);

/*
 * Variables
 */
future * fibfut[21];
int zero;
int one;

/*
 *------------------------------------------------------------------------
 * xsh_run
 *------------------------------------------------------------------------
 */
shellcmd xsh_run(int nargs, char *args[]) {
    /*
     * Setup variables
     */
    int i = 0;
    
    /*
     * Output info for '--help' argument
     */
    if (nargs == 2 && strncmp(args[1], "--help", 6) == 0) {
        kprintf("Usage: %s\n\n", args[0]);
        kprintf("Description:\n");
        kprintf("\tRuns test programs\n");
        kprintf("\tArguments taken from the command line --help and name of test program.\n");
        kprintf("\nOptions (one per invocation):\n");
        kprintf("\t--help\tdisplay this help message and exit\n");
        kprintf("\tfuture_test -r\tRuns the future test program with argument -r\n");
        return SHELL_OK;
    }
    
    /*
     * Default case where no arguments are provided
     */
    if (nargs == 1) {
        kprintf("No test function provided as an argument!\n");
        return SHELL_OK;
    }
    
    /*
     * Can't have arguments greater than 3 - as of assignment 4
     */
    if (nargs > 4) {
        fprintf(stderr, "%s: too many arguments\n", args[0]);
        fprintf(stderr, "Try '%s --help' for more information\n", args[0]);
        return SHELL_ERROR;
    }
    
    /*
     * Can't have arguments less than or equal to 1
     */
    if (nargs <= 1) {
        fprintf(stderr, "%s: too few arguments\n", args[0]);
        fprintf(stderr, "Try '%s --help' for more information\n", args[0]);
        return SHELL_ERROR;
    }
    
    /*
     * Process arguments
     */
    for(i = 1; i < nargs; i += 3){
        /*
         * If case to handle future_test
         */
        if (strncmp(args[i], "future_test", 11) == 0) {
            if (nargs > 4) {
                kprintf("future_test can't take more than 2 arguments!\n");
                return SHELL_ERROR;
            }
            
            /*
             * Run the future Fibonacci test
             */
            if (strncmp(args[i + 1], "-f", 2) == 0) {
                kprintf("Fibonacci test\n");
                int num = atoi(args[i + 2]);
                zero = 0;
                one = 1;

                kprintf("Futures Fibonacci for N=%d.\n", num);

                int j = 0;
                for (j = 0; j <= num; j++) {
                    fibfut[j] = future_alloc(FUTURE_SHARED);
                }

                for (j = 0; j <= num; j++) {
                    resume(create(ffib, 1024, 21, "ffib", 1, j));
                }

                /*
                for (j = 0; j <= num; j++) {
                    kprintf("Futures %d value is %d\n", j, *fibfut[j]->value);
                }
                */

                kprintf("Nth Fibonacci value for N=%d is %d\n", num, *fibfut[num]->value);
            /*
             * Runs the Futures test from Assignment 4
             */
            } else if (strncmp(args[i + 1], "-r", 2) == 0) {
                args++;
                future_test(2, args);
            /*
             * Runs the prodcer/consumer futures test
             */
            } else if (strncmp(args[i + 1], "-pc", 2) == 0) {
                args++;
                future_test(2, args);
                /*
                 * Else case to handle invalid input
                 */
            } else {
                kprintf("Invalid Argument Detected! Terminating process!\n");
                return SHELL_ERROR;
            }
        /*
         * Else case to handle invalid input
         */
        } else {
            kprintf("Invalid Argument Detected! Terminating process!\n");
            return SHELL_ERROR;
        }
    }
    
    return SHELL_OK;
}

/*
 * Fibonacci Futures Test
 */
int ffib(int n) {
    int minus1 = 0;
    int minus2 = 0;
    int this = 0;
    
    if (n == 0) {
        future_set(fibfut[0], zero);
        return OK;
    }
    
    if (n == 1) {
        future_set(fibfut[1], one);
        return OK;
    }

    future_get(fibfut[n-2], &minus2);
    future_get(fibfut[n-1], &minus1);

    this = minus1 + minus2;

    future_set(fibfut[n], this);
    return(0);
}
