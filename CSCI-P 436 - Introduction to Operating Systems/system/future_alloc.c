/**
 * future_alloc.c
 *
 * Part of: Assignment 4 & 5
 *
 * Created By: Matthew Lonis
 * Created On: 25 Febraury 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 2 April 2018
 */

#include <xinu.h>

/**
 * future* future_alloc(int future_flag)
 *
 * Description:
 *      - Allocates a new future (in the FUTURE_EMPTY state)
 *        in given mode. We will use the getmem() call to
 *        allocate space for the new future.
 *
 * Parameters:
 *      - int future_flag: flag to be set for this future
 *
 * Return:
 *      - future: NULL or a valid future reference
 */
future* future_alloc(int future_flags) {
    intmask mask = disable();
    
    future * mem = (future *) getmem(sizeof(future));
    
    if ((char *) mem == (char *) SYSERR) {
        restore(mask);
        return NULL;
    }
    
    mem->value = (int *) getmem(sizeof(int));
    mem->state = FUTURE_EMPTY;
    mem->flag = future_flags;
    mem->pid = NULLPROC;
    mem->set_queue = queue_alloc();
    mem->get_queue = queue_alloc();
    
    restore(mask);
    return mem;
}

