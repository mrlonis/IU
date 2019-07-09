/**
 * myqueue.h
 *
 * Part Of: Assignment 5
 *
 * Created By: Matthew Lonis
 * Created On: 29 March 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 3 April 2018
 */

typedef struct queue {
    int current_size, max_size;
    int beginning, end;
    pid32 futures[15];
} queue;
