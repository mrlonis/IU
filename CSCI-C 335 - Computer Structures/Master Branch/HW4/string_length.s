    .text
    .syntax unified
    .thumb
    .global string_length
    .type string_length, %function
string_length:
    push {r4-r7}

    ldrb    r3, [r0]
    cmp     r3, 0
    beq     .EARLYEND
    movs    r3, 0
.LOOP:
    adds    r3, r3, 1
    ldrb    r2, [r0, r3]
    cmp     r2, 0
    bne     .LOOP
.END:
    movs    r0, r3
    pop     {r4-r7}
    bx      lr
.EARLYEND:
    movs    r3, 0
    b       .END


