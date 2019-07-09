/* queue.c ---
 *
 * Filename: queue.c
 * Description: Lab10
 * Author: Alvaro Michael alvmicha
 * Partner: Adam Esker eskera
 * Due: 11/10/2017
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 0
 * URL:
 * Doc URL:
 * Keywords:
 * Compatibility:
 *
 */

/* Commentary:
 *
 *
 *
 */

/* Change Log:
 *
 *
 */

/* This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 3, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth
 * Floor, Boston, MA 02110-1301, USA.
 */

/* Code: */

#include "queue.h"
#include <stdio.h>

//Initialize buf by setting head and tail to 0.
void init_queue(queue_t *buf) {
  buf->head = 0;
  buf->tail = 0;
}

//Test if the queue is full.
//(This is used to determine if we can enqueue.)
int queue_full(queue_t *buf){
  return (((buf->tail + 1) % QUEUE_SIZE) == buf->head);
}

//Insert data into buf at tail (and increment tail).
int enqueue (queue_t *buf, int data) {
  
  //Test if buf is full.
  if (queue_full(buf)) {
    return 0;
  }
  else{
    buf->buffer[buf->tail] = data;
    buf->tail = (buf->tail + 1) % QUEUE_SIZE;
    return 1;
  }
}

//Remove item from head of buf, increment head, and store item into data
int dequeue (queue_t *buf, int *data) {
  if (queue_empty(buf)) {
    return 0;
  }
  *data = buf->buffer[buf->head];
  buf->head = (buf->head + 1) % QUEUE_SIZE;
  return *data;
}

//Determine if buf is empty (i.e. head = tail)
int queue_empty(queue_t *buf) {
  return buf->head == buf->tail;
}

//Print the items in buf
void printBuffer(queue_t *buf){
  int i;
  int cur;
  for (i = 0; i<QUEUE_SIZE; i++){
    cur = buf->buffer[i];
    printf("i: %d buf: %d \n",i,cur);
  }


}


/* queue.c ends here */
