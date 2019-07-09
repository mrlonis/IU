    .text
    .syntax unified
    .thumb
    .global mult_by_5
    .type mult_by_5, %function
mult_by_5:
    push    {r4-r7}
    lsls    r3, r0, 2
    adds    r0, r3, r0
    pop     {r4-r7}
    bx	    lr
