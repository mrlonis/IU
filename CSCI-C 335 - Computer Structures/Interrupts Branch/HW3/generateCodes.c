/**
 * generateCodes.c
 *
 * Created By: Matthew Lonis
 * Created On: 23 October 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: 23 October 2017
 */

#include <stdio.h>
#include <stdlib.h>

void main(void) {
    unsigned int code = 0;
    int i = 1;
    
    while (code < 65536) {
        printf("    %04x", code);
        
        if (i % 8 == 0) {
            printf("\n");
        }
        
        code++;
        i++;
    }
    
    printf("\n");
}
