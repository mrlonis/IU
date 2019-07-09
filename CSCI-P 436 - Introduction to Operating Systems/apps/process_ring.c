/**
 * process_ring.c
 *
 * Part Of: Assignment 2
 *
 * Created By: Matthew Lonis
 * Created On: 23 January 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 4 February 2018
 */

/*
 * process_ring.c
 */

/*
 * Include statements
 */
#include <xinu.h>

/*
 * Definitions
 */
#define POLL 0
#define SYNC 1

/*
 * process_ring process
 */
process process_ring(int this_process_index, int number_of_processes, int poll_or_sync) {
    /*
     * This is an arbitrary name. I use it to store data during processing.
     *
     * During polling, this value s used to store the inbox data when the
     * the process is woken up. It is used as a failsafe to make sure the
     * process wont continue if it doesn't get suspended in time. During
     * my experimentation, i noticed when the number of process was greater
     * than 8, the Xinu OS would allow a process to execute even when it
     * wasn't the one that was supposed to be processing, resulting in
     * data races. This value ensures the process wont proceed unless
     * another process changes its inbox value.
     *
     * During sync, value is used to store the value of the message being
     * sent to the process since we need a place to store the message.
     */
    int32 value = 0;
    
    /*
     * While loop terminates if inbox is less than -1.
     * It should never get to this point but this is a failsafe.
     */
    while(inbox[this_process_index] >= 0) {
        /*
         * If Polling:
         *      Make sure your inbox is updated before proceeding (uses
         *      value variable to do this). Need to do this because the
         *      process that is updating the inbox will put to sleep the
         *      previous process before it. We need to include a check to
         *      ensure the previous process wont go ahead and update the
         *      inbox again because it just ran and is about to be put to
         *      sleep by the process that is updating the inbox.
         */
        if (poll_or_sync == POLL && value != inbox[this_process_index] && inbox[this_process_index] >= 0) {
            /*
             * If this is the beginning dont worry about suspending.
             * Otherwise, we need to suspend the process that resumed us.
             */
            if (this_process_index == 0) {
                round += 1;
            }
            
            /*
             * Set value equal to the current value of this process's inbox.
             * This prevents the process from executing until another
             * process polls and changes its inbox value
             */
            value = inbox[this_process_index];
            
            /*
             * Figure out what the next process is an update its inbox, print
             * out the required message and resume it.
             */
            int next_process_index = (this_process_index + 1) % number_of_processes;
            inbox[next_process_index] = inbox[this_process_index] - 1;
            
            kprintf("Ring Element %d : Round %d : Value : %d\n", this_process_index, round, inbox[this_process_index]);
            resume(ring[next_process_index]);
        } else if (poll_or_sync == SYNC) {
            /*
             * If this is the beginning, dont worry about receiving a
             * message, otherwise receive the message and update your
             * inbox accordingly.
             */
            
            if (!(this_process_index == 0 && round == -1)) {
                value = receive();
                
                /*
                 * If the value received is zero, we are done and need to
                 * goto the end. This isnt entirely necessary since our while
                 * loop ends when index is less than zero. We could keep going
                 * and take care of it later but this allows for some slight
                 * optimization.
                 */
                if (value == 0) {
                    inbox[this_process_index] = value;
                    kprintf("Ring Element %d : Round %d : Value : %d\n", this_process_index, round, inbox[this_process_index]);
                    goto end;
                }
                
                inbox[this_process_index] = value;
            }
            
            /*
             * Figure out what the next process is, print out the required
             * message, send the process its new value, and then resume it.
             */
            int next_process_index = (this_process_index + 1) % number_of_processes;
            
            /*
             * Update round if this is process zero
             */
            if (this_process_index == 0) {
                round += 1;
            }
            
            kprintf("Ring Element %d : Round %d : Value : %d\n", this_process_index, round, inbox[this_process_index]);
            
            send(ring[next_process_index], inbox[this_process_index] - 1);
            
            resume(ring[next_process_index]);
        }
    }
    
    /*
     * Labeled end: to allow easy goto statements to break out of the while loop.
     * Regardless of implementation, the end of the process_ring app will be
     * the same.
     */
end:
    resume(parent_process_id);
    return SHELL_OK;
}

/*
 * end of process_ring.c
 */

