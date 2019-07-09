	.text
	.syntax unified
	.thumb
	.global	abs	
	.type abs, %function
abs:
	push {r4-r7}
/*
	Your implementation goes here. 
*/
	pop {r4-r7}	
	bx	lr
