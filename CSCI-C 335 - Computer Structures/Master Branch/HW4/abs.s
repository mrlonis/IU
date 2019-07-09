    .text
    .syntax unified
    .thumb
    .global abs	
    .type abs, %function
abs:
    push {r4-r7}
    asrs r3,r0,31
    adds r0,r0,r3
    eors r0,r3
    pop  {r4-r7}	
    bx	 lr
