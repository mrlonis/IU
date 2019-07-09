	.text
	.syntax unified
	.thumb
	.global	alloc
	.type	alloc, %function
alloc:
	nop
	push    {r3,lr}
	bl      malloc
	pop     {r3,pc}

	.global	dealloc
	.type	deallocc, %function
dealloc:
	nop
	push    {r3,lr}
	bl      free
	pop     {r3,pc}
	.end
	
