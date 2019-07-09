/**
 * future_test.c
 *
 * Part Of: Assignment 4 & 5
 *
 * Created By: Matthew Lonis
 * Created On: 25 February 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 3 April 2018
 */

#include <xinu.h>

/**
 * Test Futures
 */
uint32 future_test(int nargs, char *args[]) {
    int ring = 0;
    int future_flags = FUTURE_EXCLUSIVE;
    int ring_count = 10;
    int final_val;
    int i;
    
#ifndef _FUTURE_H_
    kprintf("no support for futures (NFUTURES not defined.)\n");
    return OK;
#endif
    
    if (nargs == 2 && strncmp(args[1], "-r", 2) == 0) {
        ring = 1;
        kprintf("Producer/consumer process ring\n");
    } else if (nargs == 2 && strncmp(args[1], "-pc", 2) == 0) {
        ring = 2;
        kprintf("Partial test program\n");
    } else {
        kprintf("No valid options\n");
        return(OK);
    }
    
    if (ring == 1) {
        future *first, *in, *out = NULL;
        first = future_alloc(future_flags);
        in = first;
        
        for (i = 0; i < ring_count; i++) {
            out = future_alloc(future_flags);
            resume(create(future_ring, 1024, 20, "", 2, in, out));
            in = out;
        }
        
        kprintf("master sets %d\n", ring_count);
        
        future_set(first, ring_count);        
        future_get(out, &final_val);
        
        kprintf("master gets %d\n", final_val);
        
        return(OK);
    } else if (ring == 2) {
        future *f_exclusive, *f_shared, *f_queue;
        
        f_exclusive = future_alloc(FUTURE_EXCLUSIVE);
        f_shared = future_alloc(FUTURE_SHARED);
        f_queue = future_alloc(FUTURE_QUEUE);
        
        // Test FUTURE_EXCLUSIVE
        // kprintf("\nTesting FUTURE_EXCLUSIVE\n\n");
        resume( create(future_cons, 1024, 23, "fcons1", 1, f_exclusive) );
        resume( create(future_prod, 1024, 23, "fprod1", 2, f_exclusive, 1) );
        // kprintf("\nFinished Testing FUTURE_EXCLUSIVE\n\n");
        
        // Test FUTURE_SHARED
        // kprintf("\nTesting FUTURE_SHARED\n\n");
        resume( create(future_cons, 1024, 22, "fcons2", 1, f_shared) );
        resume( create(future_cons, 1024, 22, "fcons3", 1, f_shared) );
        resume( create(future_cons, 1024, 22, "fcons4", 1, f_shared) );
        resume( create(future_cons, 1024, 22, "fcons5", 1, f_shared) );
        resume( create(future_prod, 1024, 22, "fprod2", 2, f_shared, 2) );
        // kprintf("\nFinished Testing FUTURE_SHARED\n\n");
        
        // Test FUTURE_QUEUE
        // kprintf("\nTesting FUTURE_QUEUE\n\n");
        resume( create(future_cons, 1024, 21, "fcons6", 1, f_queue) );
        resume( create(future_cons, 1024, 21, "fcons7", 1, f_queue) );
        resume( create(future_cons, 1024, 21, "fcons8", 1, f_queue) );
        resume( create(future_cons, 1024, 21, "fcons9", 1, f_queue) );
        resume( create(future_prod, 1024, 21, "fprod3", 2, f_queue, 3) );
        resume( create(future_prod, 1024, 21, "fprod4", 2, f_queue, 4) );
        resume( create(future_prod, 1024, 21, "fprod5", 2, f_queue, 5) );
        resume( create(future_prod, 1024, 21, "fprod6", 2, f_queue, 6) );
        // kprintf("\nFinished Testing FUTURE_QUEUE\n\n");
        
        syscall res_exclusive = future_free(f_exclusive);
        syscall res_shared = future_free(f_shared);
        syscall res_queue = future_free(f_queue);
        
        if (res_exclusive == SYSERR || res_shared == SYSERR || res_queue == SYSERR) {
            kprintf("future_free error!\n");
            kprintf("exclusive = %d - shared = %d - queue = %d\n", res_exclusive, res_shared, res_queue);
        }
    }
    
    return(OK);
}

uint future_ring(future *in, future *out) {
    int val;
    future_get(in, &val);
    kprintf("Process %d gets %d, puts %d\n", getpid(), val, val-1);
    val--;
    future_free(in);
    future_set(out, val);
    return OK;
}

uint future_prod(future * fut, int n) {
    // kprintf("Produced (%d) %d\n", getpid(), n);
    kprintf("Produced %d\n", n);
    future_set(fut, n);
    return OK;
}

uint future_cons(future * fut) {
    int i;
    syscall status;
    status = future_get(fut, &i);
    
    if (status == SYSERR) {
        kprintf("future_get failed\n");
        return -1;
    }
    
    // kprintf("Consumed (%d) %d\n", getpid(), i);
    printf("Consumed %d\n", i);
    return OK;
}
