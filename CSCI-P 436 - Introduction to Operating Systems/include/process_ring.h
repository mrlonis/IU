/**
 * process_ring.h
 *
 * Part Of: Assignment 2
 *
 * Created By: Matthew Lonis
 * Created On: 23 January 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 4 February 2018
 */

 /*
  * process_ring.h
  */

/*
 * Global variables defined in xsh_process_ring.c
 */
extern volatile int inbox[64];
extern volatile pid32 ring[64];
extern volatile int round;
extern volatile int parent_process_id;

/*
 * Definition for process_ring processes
 */
process process_ring(int this_process_index, int number_of_processes, int poll_or_sync);

/*
 * End of process_ring.h
 */
