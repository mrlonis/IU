	.text
	.syntax unified
	.thumb
	.global	gcd	
	.type gcd, %function
gcd:
	push {r4-r7}
/*
	Your implementation goes here. 
*/
	pop {r4-r7}
	bx	lr
