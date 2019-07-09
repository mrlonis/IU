	.text
	.syntax unified
	.thumb
	.global	or
	.type	or, %function
or:
	nop
	orrs	r0,r1
	mov     pc,lr
	.end
