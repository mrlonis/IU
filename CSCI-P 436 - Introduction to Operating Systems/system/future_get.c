/**
 * future_get.c
 *
 * Part of: Assignment 4 & 5
 *
 * Created By: Matthew Lonis
 * Created On: 25 Febraury 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 4 April 2018
 */

#include <xinu.h>

syscall future_exclusive_get(future* f, int* value) {
    f->state = FUTURE_WAITING;
    f->pid = getpid();
    
    // kprintf("future_exclusive_get (%d): Suspending pid %d\n", getpid(), getpid());
    suspend(getpid());
    
    *value = *(f->value);
    // kprintf("future_exclusive_get (%d): Retreived %d\n", getpid(), *value);
    f->state = FUTURE_EMPTY;
    f->pid = NULLPROC;
    return OK;
}

syscall future_shared_get(future* f, int* value) {
    if (f->state == FUTURE_VALID) {
        *value = *(f->value);
        return OK;
    } else {
        pid32 pid = getpid();
        
        if (queue_push(f->get_queue, pid) == SYSERR) {
            return SYSERR;
        }
        
        // kprintf("future_shared_get (%d): Suspending pid %d\n", getpid(), pid);
        suspend(pid);
        *value = *(f->value);
        return OK;
    }
}

syscall future_queue_get(future* f, int* value) {
    if (f->state == FUTURE_VALID) {
        *value = *(f->value);
        pid32 proc;
        
        if (queue_pop(f->set_queue, &proc) == OK) {
            f->state = FUTURE_EMPTY;
            // kprintf("future_queue_get (%d): Resuming pid %d\n", getpid(), proc);
            resume(proc);
            return OK;
        }
        
        return SYSERR;
    }
    
    //otherwise, suspend current thread
    pid32 pid = getpid();

    if (queue_push(f->get_queue, pid) == SYSERR) {
        return SYSERR;
    }
    
    // kprintf("future_queue_get (%d): Suspending pid %d\n", getpid(), pid);
    suspend(pid);
    *value = *(f->value);
    f->state = FUTURE_EMPTY;
    return OK;
}


/**
 * syscall future_get(future *f, int *value)
 *
 * Description:
 *      - Get the value of a future set by an operation and change the state of future from FUTURE_VALID to FUTURE_EMPTY.
 *
 * Parameters:
 *      - future *f: future on which to wait for and obtain value
 *      - int *value: variable in which to obtain the value from a future
 *
 * Return:
 *      - syscall: SYSERR or OK
 */
syscall future_get(future* f, int* value) {
    intmask mask = disable();
    
    if (f == NULL || isbadpid(f->pid) || f->state == FUTURE_WAITING) {
        kprintf("future_get: future error...\n");
        restore(mask);
        return SYSERR;
    }
    
    syscall res = SYSERR;
    
    if (f->flag == FUTURE_EXCLUSIVE) {
        res = future_exclusive_get(f, value);
    } else if (f->flag == FUTURE_SHARED) {
        res = future_shared_get(f, value);
    } else if (f->flag == FUTURE_QUEUE) {
        res = future_queue_get(f, value);
    } else {
        kprintf("future_get: future flag error - flag = %d - pid = %d\n", f->flag, getpid());
    }
    
    restore(mask);
    return res;
}
