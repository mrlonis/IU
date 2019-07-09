	.text
	.syntax unified
	.thumb
	.global	fib	
	.type fib, %function
fib:
    push  {r4-r7}
    movs  r5, r0
    movs  r0, 0
    cmp   r5, 0
    beq   .END
    cmp   r5, 2
    ble   .PREPARERETURNVALUE
    subs  r5, r5, 2
    movs  r4, 0 @ i
    movs  r3, 1 @ prev2
    movs  r2, 1 @prev1
    movs  r1, 1 @val
    b     .UPDATEVAL
.LOOP:
    movs  r3, r2
    movs  r2, r1
.UPDATEVAL:
    adds  r1, r2, r3
    adds  r4, 1
    cmp   r4, r5
    blt   .LOOP
    movs  r0, r1
.END:
    pop   {r4-r7}
    bx    lr
.PREPARERETURNVALUE:
    movs  r0, 1
    b     .END
