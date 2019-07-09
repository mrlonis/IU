/**
 * myqueue.c
 *
 * Part Of: Assignment 5
 *
 * Created By: Matthew Lonis
 * Created On: 29 March 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 4 April 2018
 */

#include <xinu.h>

queue * queue_alloc() {
    queue * q = (queue *) getmem(sizeof(queue));
    
    if ((char *) q == (char *) SYSERR) {
        return (queue *) SYSERR;
    }
    
    q->beginning = q->end = -1;
    q->current_size = 0;
    q->max_size = 15;
    
    return q;
}

syscall queue_free(queue* q) {
    if (q == NULL) {
        return SYSERR;
    }
    
    return freemem((char*) q, sizeof(queue));
}

syscall queue_push(queue* q, pid32 item) {
    if (q == NULL) {
        return SYSERR;
    }
    
    if ((q->beginning == 0 && q->end == q->max_size -1)
        || (q->end + 1 == q->beginning)) {
        return SYSERR;
    }
    
    if (q->end == q->max_size - 1) {
        q->end = 0;
    } else {
        q->end++;
    }
    
    q->futures[q->end] = item;
    
    if (q->beginning == -1) {
        q->beginning = 0;
    }
    
    return OK;
}

syscall queue_pop(queue* q, pid32 * item) {
    if (q == NULL) {
        return SYSERR;
    }
    
    if (q->beginning == -1) {
        return SYSERR;
    }
    
    *item = q->futures[q->beginning];
    
    if (q->beginning == q->end) {
        q->beginning = q->end = -1;
    } else {
        if (q->beginning == q->max_size - 1) {
            q->beginning = 0;
        } else {
            q->beginning++;
        }
    }
    
    return OK;
}
