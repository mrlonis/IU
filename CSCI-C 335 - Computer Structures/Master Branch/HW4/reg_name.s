    .text
    .syntax unified
    .thumb
    .global reg_name
    .type reg_name, %function
reg_name:
    push    {r4-r7}
    ldr     r3, .nameArray
    lsls    r0, r0, 2
    ldr     r0, [r0, r3]
    pop     {r4-r7}
    bx	    lr
    .align  2
.nameArray:
    .word       namesAS
    .global     namesAS
    .data
    .align      2
    .type       namesAS, %object
    .size       namesAS, 64
namesAS:
    .word    .R0
    .word    .R1
    .word    .R2
    .word    .R3
    .word    .R4
    .word    .R5
    .word    .R6
    .word    .R7
    .word    .R8
    .word    .R9
    .word    .R10
    .word    .R11
    .word    .R12
    .word    .R13
    .word    .R14
    .word    .R15
    .align  2
.R0:
    .ascii    "r0\000"
    .space    1
.R1:
    .ascii    "r1\000"
    .space    1
.R2:
    .ascii    "r2\000"
    .space    1
.R3:
    .ascii    "r3\000"
    .space    1
.R4:
    .ascii    "r4\000"
    .space    1
.R5:
    .ascii    "r5\000"
    .space    1
.R6:
    .ascii    "r6\000"
    .space    1
.R7:
    .ascii    "r7\000"
    .space    1
.R8:
    .ascii    "r8\000"
    .space    1
.R9:
    .ascii    "r9\000"
    .space    1
.R10:
    .ascii    "r10\000"
.R11:
    .ascii    "r11\000"
.R12:
    .ascii    "r12\000"
.R13:
    .ascii    "r13\000"
.R14:
    .ascii    "r14\000"
.R15:
    .ascii    "r15\000"
