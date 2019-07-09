/**
 * max_array_c.c
 *
 * Created By: Matthew Lonis
 * Created On: 11 November 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: 11 November 2017
 *
 * Part of: Homework 4
 */

unsigned int max_array_c(unsigned int *p, int size) {
    int i = 0;
    int max = 0;

    while (i < size) {
        if (*(p + i) > max) {
            max = *(p + i);
        }

        i = i + 1;
    }

    return max;
}
