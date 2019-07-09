	.text
	.code 16
	.syntax unified
	.thumb
	.align 2
	.global	addshift	
	.type	addshift, %function
addshift:
	adds	r0, r0, r1, lsl #2
	bx	lr
