    .text
    .syntax unified
    .thumb
    .global max_array
    .type max_array, %function
max_array:
    push   {r4-r7}
    cmp    r1, 0
    ble    .EARLYEND
    lsls   r1, r1, 2
    movs   r3, r0
    adds   r1, r0, r1
    movs   r4, 0
.LOOP:
    ldr    r2, [r3]
    movs   r0, r4
    cmp    r2, r0
    bls    .LOOPCONDITIONALSUCCESS
    movs   r4, r2
.LOOPCONDITIONALSUCCESS:
    cmp    r2, r0
    bls    .LOOPCONDITIONALTWO
    movs   r0, r2
.LOOPCONDITIONALTWO:
    adds   r3, r3, 4
    cmp    r3, r1
    bne    .LOOP
.END:
    pop    {r4-r7}
    bx     lr
.EARLYEND:
    movs   r0, 0
    b      .END


