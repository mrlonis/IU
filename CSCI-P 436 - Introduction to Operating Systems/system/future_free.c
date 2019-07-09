/**
 * future_free.c
 *
 * Part of: Assignment 4 & 5
 *
 * Created By: Matthew Lonis
 * Created On: 25 Febraury 2018
 * Last Modified By: Matthew Lonis
 * Last Modified 2 April 2018
 */

#include <xinu.h>

/**
 * syscall future_free(future* f)
 *
 * Description
 *      - Free the allocated future. This function will simply
 *        free the space assigned to Future. Use the freemem()
 *        call to free the future and the value.
 *
 * Parameters:
 *      - future* f: future to free
 *
 * Return:
 *      - syscall: SYSERR or OK
 */
syscall future_free(future * f) {
    intmask mask = disable();
    int flag = f->flag;
    
    if (f == NULL || isbadpid(f->pid)) {
        restore(mask);
        return SYSERR;
    }
    
    // kprintf("future_free (flag = %d): f->value = %d\n", flag, *(f->value));
    syscall result_of_free_value = freemem((char *) f->value, sizeof(int));
    f->value = NULL;
    
    syscall result_of_free_set_queue = queue_free(f->set_queue);
    f->set_queue = NULL;
    
    syscall result_of_free_get_queue = queue_free(f->get_queue);
    f->get_queue = NULL;
    
    syscall result_of_free_struct = freemem((char *) f, sizeof(future));
    f = NULL;
    
    syscall res = SYSERR;
    
    if (result_of_free_struct == OK && result_of_free_value == OK && result_of_free_set_queue == OK && result_of_free_get_queue == OK) {
        res = OK;
    } else {
        kprintf("future_free (flag = %d): error - result_of_free_value = %d, result_of_free_set_queue = %d, result_of_free_get_queue = %d, result_of_free_struct = %d\n", flag, result_of_free_value, result_of_free_set_queue, result_of_free_get_queue, result_of_free_struct);
    }
    
    restore(mask);
    return res;
}
