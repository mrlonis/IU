/**
 * future.h
 *
 * Part Of: Assignment 4 & 5
 *
 * Created By: Matthew Lonis
 * Created On: 25 February 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 3 April 2018
 */

#ifndef _FUTURE_H_
#define _FUTURE_H_

/* define states */
#define FUTURE_EMPTY    0
#define FUTURE_WAITING  1
#define FUTURE_VALID    2

/* modes of operation for future*/
#define FUTURE_EXCLUSIVE  1
#define FUTURE_SHARED     2
#define FUTURE_QUEUE      3

typedef struct futent {
    int *value;
    int flag;
    int state;
    pid32 pid;
    queue * set_queue;
    queue * get_queue;
} future;

#endif /* _FUTURE_H_ */
