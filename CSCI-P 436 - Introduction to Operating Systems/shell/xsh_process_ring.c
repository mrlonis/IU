/**                                                                             
 * xsh_process_ring.c                                                               
 *                                                                              
 * Part Of: Assignment 2                                                        
 *                                                                              
 * Created By: Matthew Lonis                                                    
 * Created On: 23 January 2018                                                  
 * Last Modified By: Matthew Lonis                                              
 * Last Modified On: 4 February 2018
 */

/*
 * xsh_process_ring.c - xsh_process_ring
 */

/*
 * Include statements
 */
#include <xinu.h>

/*
 * Definitions
 */
#define MAX_PROCESSES 64
#define MIN_PROCESSES 0
#define DEFAULT_PROCESSES 2

#define MAX_ROUNDS 100
#define MIN_ROUNDS 0
#define DEFAULT_ROUNDS 3

#define DEFAULT_IMPLEMENTATION 0

#define POLL 0
#define SYNC 1

/*
 * Global variables
 */
volatile int inbox[64];
volatile pid32 ring[64];
volatile int round;
volatile int parent_process_id;

int number_of_processes;
int number_of_rounds;
int countdown;
int poll_or_sync;

uint32 start_time;
uint32 end_time;

/*
 *------------------------------------------------------------------------
 * xsh_process_ring - Print countdown of numbers
 *------------------------------------------------------------------------
 */
shellcmd xsh_process_ring(int nargs, char *args[]) {
    /*
     * Setup variables
     */
    gettime(&start_time);
    
	parent_process_id = getpid();
    
	number_of_processes = DEFAULT_PROCESSES;
	number_of_rounds = DEFAULT_ROUNDS;
	poll_or_sync = DEFAULT_IMPLEMENTATION;
    
    round = -1;
    end = 0;
    
    int i = 0;
    
    /*
     * I don't think this is necessary but it ensures
     */
    for (i = 0; i < MAX_PROCESSES; i++) {
        inbox[i] = 0;
        ring[i] = 0;
    }

	/*
     * Output info for '--help' argument
     */
	if (nargs == 2 && strncmp(args[1], "--help", 6) == 0) {
		kprintf("Usage: %s\n\n", args[0]);
		kprintf("Description:\n");
		kprintf("\tPrints the countdown of numbers\n");
		kprintf("\tArguments taken from the command line are -p -r and -i --help.\n");
		kprintf("\nOptions (one per invocation):\n");
		kprintf("\t--help\tdisplay this help message and exit\n");
        kprintf("\t-p\tSpecifies number of processes with which to countdown <0-64> with a default of 2.\n");
        kprintf("\n\t\tExample:\tprocess_ring -p 34\tCreates process_ring with 34 processes (and 3 rounds).\n\n");
        kprintf("\t-r\tSpecifies number of rounds to countdown <0-100> with a default of 3.\n");
        kprintf("\n\t\tExample:\tprocess_ring -r 34\tCreates process_ring with 34 rounds (and 2 processes).\n\n");
        kprintf("\t-i\tSpecifies which implementation to use <poll or sync>\n");
        kprintf("\n\t\tExample:\tprocess_ring -i sync\tImplements process_ring using synchronization (message passing).\n");
		return SHELL_OK;
	}

    /*
     * Default case where no arguments are provided
     */
	if (nargs == 1) {
		countdown = (number_of_processes * number_of_rounds) - 1;
		inbox[0] = countdown;

		for (i = 0; i < number_of_processes; i++) {
		    ring[i] = create(process_ring, 1024, 20, "process_ring", 3, i, number_of_processes, poll_or_sync);
		}
        
        for (i = 0; i < number_of_processes; i++) {
            resume(ring[i]);
        }

		suspend(parent_process_id);

		for(i = 0; i < number_of_processes; i++) {
			kill(ring[i]);
		}

		gettime(&end_time);
		kprintf("Elapsed Seconds: %d\n", (end_time - start_time));
		return SHELL_OK;
	}

    /*
     * Can't have arguments greater than 7
     */
	if (nargs > 7) {
		fprintf(stderr, "%s: too many arguments\n", args[0]);
		fprintf(stderr, "Try '%s --help' for more information\n", args[0]);
		return SHELL_ERROR;
	}

    /*
     * Can't have arguments less than 1
     */
	if (nargs < 1) {
		fprintf(stderr, "%s: too few arguments\n", args[0]);
		fprintf(stderr, "Try '%s --help' for more information\n", args[0]);
		return SHELL_ERROR;
	}

    /*
     * Process arguments
     */
	for(i = 1; i < nargs; i += 2){
		if (strncmp(args[i], "-p", 2) == 0) {
            number_of_processes = atoi(args[i + 1]);

			if (number_of_processes > MAX_PROCESSES || number_of_processes < MIN_PROCESSES) {
                kprintf("Invalid Number of Processes. Default (2) will be applied...\n");
				number_of_processes = DEFAULT_PROCESSES;
			}

			kprintf("Number of Processes: %d\n", number_of_processes);
            
            if (number_of_processes == MIN_PROCESSES) {
                kprintf("With zero processes, no countdown can occur. Terminating early!\n");
                goto end;
            }
		} else if (strncmp(args[i], "-r", 2) == 0) {
            number_of_rounds = atoi(args[i + 1]);

			if (number_of_rounds < MIN_ROUNDS) {
                kprintf("Invalid Round Argument. Default (3) will be applied...\n");
				number_of_rounds = DEFAULT_ROUNDS;
			}

			kprintf("Number of Rounds: %d\n", number_of_rounds);
            
            if (number_of_rounds == MIN_ROUNDS) {
                kprintf("With zero rounds, no countdown can occur. Terminating early!\n");
                goto end;
            }
		} else if (strncmp(args[i], "-i", 2) == 0) {
			if(strncmp(args[i+1], "poll", 4) == 0) {
				poll_or_sync = POLL;
			} else if(strncmp(args[i+1], "sync", 4) == 0) {
				poll_or_sync = SYNC;
            } else {
                kprintf("Invalid Implementation Given. Default (Polling) will be applied...\n");
                poll_or_sync = DEFAULT_IMPLEMENTATION;
            }
		} else if (i == 1 || i == 2) {
			if (i == 1) {
				number_of_processes = atoi(args[i]);
                
                if (number_of_processes > MAX_PROCESSES || number_of_processes < MIN_PROCESSES) {
                    kprintf("Invalid Number of Processes. Default (2) will be applied...\n");
                    number_of_processes = DEFAULT_PROCESSES;
                }
                
                kprintf("Number of Processes: %d\n", number_of_processes);
                i--;
                
                if (number_of_processes == MIN_PROCESSES) {
                    kprintf("With zero processes, no countdown can occur. Terminating early!\n");
                    goto end;
                }
			} else if (i == 2) {
				number_of_rounds = atoi(args[i]);
                
                if (number_of_rounds < MIN_ROUNDS || number_of_rounds > MAX_ROUNDS) {
                    kprintf("Invalid Round Argument. Default (3) will be applied...\n");
                    number_of_rounds = DEFAULT_ROUNDS;
                }
                
                kprintf("Number of Rounds: %d\n", number_of_rounds);
                
                if (number_of_rounds == MIN_ROUNDS) {
                    kprintf("With zero rounds, no countdown can occur. Terminating early!\n");
                    goto end;
                }
			}
        } else {
            kprintf("Invalid Argument Detected! Terminating process!\n");
            goto end;
        }
	}

    /*
     * Execution following argument capture
     */
	countdown = (number_of_processes * number_of_rounds) - 1;
    
    if (countdown <= 0) {
        kprintf("Since countdown = %d, which is less than or equal to zero, there is no way to count down to zero. Terminating early!\n", countdown);
        goto end;
    }
    
	inbox[0] = countdown;
	for(i = 0; i < number_of_processes; i++) {
	    ring[i] = create(process_ring, 1024, 20, "process_ring", 3, i, number_of_processes, poll_or_sync);
	}
    
    for(i = 0; i < number_of_processes; i++) {
        resume(ring[i]);
    }

	suspend(parent_process_id);

    /*
     * This proceeds immediately after all the process_ring children
     * have counted down to zero. The parent function kills the processes.
     */
	for(i = 0; i < number_of_processes; i++) {
	    kill(ring[i]);
	}

end:
    gettime(&end_time);
    // kprintf("Start time: %d\n", start_time);
    // kprintf("End time: %d\n", end_time);
	kprintf("Elapsed Seconds: %d\n", (end_time - start_time));
	return SHELL_OK;
}
