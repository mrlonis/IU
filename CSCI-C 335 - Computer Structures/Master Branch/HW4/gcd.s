	.text
	.syntax unified
	.thumb
	.global	gcd	
	.type gcd, %function
gcd:
	push  {r4-r7}
.FIRSTWHILELOOPCONDITIONAL:
    movs  r3, r0
    orrs  r3, r1
    lsls  r2, r3, 31
    bmi   .SETDTOZERO
    movs  r3, 0
    movs  r4, 1
.FIRSTWHILELOOP:
    asrs  r0, r0, 1
    asrs  r1, r1, 1
    adds  r3, r3, 1
    movs  r2, r0
    orrs  r2, r1
    tst   r4, r2
    beq   .FIRSTWHILELOOP
    b     .SECONDWHILELOOP
.SETDTOZERO:
    movs  r3, 0
.SECONDWHILELOOP:
    cmp   r0, r1
    beq   .PREPARERETURNVALUE
    movs  r2, 1
.SLFIRSTCONDITIONAL:
    tst   r2, r0
    bne   .SLSECONDCONDITIONAL
    asrs  r0, r0, 1
    b     .CHECKIFSECONDWHILELOOPCONDITIONALISTRUE
.SLSECONDCONDITIONAL:
    tst   r2, r1
    bne   .SLTHIRDCONDITIONAL
    asrs  r1, r1, 1
    b     .CHECKIFSECONDWHILELOOPCONDITIONALISTRUE
.SLTHIRDCONDITIONAL:
    cmp   r0, r1
    ble  .SLELSE
    subs  r0, r0, r1
    asrs  r0, r0, 1
    b     .CHECKIFSECONDWHILELOOPCONDITIONALISTRUE
.SLELSE:
    subs  r1, r1, r0
    asrs  r1, r1, 1
.CHECKIFSECONDWHILELOOPCONDITIONALISTRUE:
    cmp   r0, r1
    bne   .SLFIRSTCONDITIONAL
.PREPARERETURNVALUE:
    lsls  r0, r0, r3
.END:
    pop  {r4-r7}
    bx	 lr
