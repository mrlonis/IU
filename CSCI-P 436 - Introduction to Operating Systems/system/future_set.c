/**
 * future_set.c
 *
 * Part of: Assignment 4 & 5
 *
 * Created By: Matthew Lonis
 * Created On: 25 Febraury 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 4 April 2018
 */

#include <xinu.h>

syscall future_exclusive_set(future* f, int value) {
    *(f->value) = value;
    
    // kprintf("future_exclusive_set (%d): Set %d\n", getpid(), value);
    f->state = FUTURE_VALID;
    
    // kprintf("future_exclusive_set (%d): Resuming pid %d\n", getpid(), f->pid);
    resume(f->pid);
    return OK;
}

syscall future_shared_set(future* f, int value) {
    *(f->value) = value;
    f->state = FUTURE_VALID;
    
    pid32 proc;
    
    while (queue_pop(f->get_queue, &proc) == OK) {
        // kprintf("future_shared_set (%d): Resuming pid %d\n", getpid(), proc);
        resume(proc);
    }

    return OK;
}

syscall future_queue_set(future* f, int value) {
    *(f->value) = value;
    f->state = FUTURE_VALID;
    
    pid32 proc;
    
    if (queue_pop(f->get_queue, &proc) == OK) {
        // kprintf("future_queue_set (%d): Resuming pid %d\n", getpid(), proc);
        resume(proc);
    } else {
        pid32 pid = getpid();
        queue_push(f->set_queue, pid);
        // kprintf("future_queue_set (%d): Suspending pid %d\n", getpid(), pid);
        suspend(pid);
        
        if (queue_pop(f->get_queue, &proc) == OK) {
            // kprintf("future_queue_set (%d): Resuming pid %d\n", getpid(), proc);
            resume(proc);
        } else {
            return SYSERR;
        }
    }
    
    return OK;
}

/**
 * syscall future_set(future *f, int *value)
 *
 * Description:
 *      - Set a value in a future and changes state
 *        from FUTURE_EMPTY or FUTURE_WAITING to
 *        FUTURE_VALID.
 *
 * Parameters:
 *      - future  *f: future in which to set the value
 *      - int *value: result of an operation to be set as value in a future
 *
 * Return:
 *      - syscall: SYSERR or OK
 */
syscall future_set(future *f, int value) {
    intmask mask = disable();
    
    if (f == NULL || isbadpid(f->pid) || f->state == FUTURE_VALID) {
        restore(mask);
        return SYSERR;
    }
    
    syscall res = SYSERR;
    
    if (f->flag == FUTURE_EXCLUSIVE) {
        res = future_exclusive_set(f, value);
    } else if (f->flag == FUTURE_SHARED) {
        res = future_shared_set(f, value);
    } else if (f->flag == FUTURE_QUEUE) {
        res = future_queue_set(f, value);
    }
    
    restore(mask);
    return res;
}
