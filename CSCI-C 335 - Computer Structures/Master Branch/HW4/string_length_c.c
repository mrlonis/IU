/**
 * string_length_c.c
 *
 * Created By: Matthew Lonis
 * Created On: 11 November 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: 11 November 2017
 *
 * Part of: Homework 4
 */

 int string_length_c(char *c) {
     int i = 0;
     while (*(c + i) != '\0') {
         i = i + 1;
     }

     return i;
 }
