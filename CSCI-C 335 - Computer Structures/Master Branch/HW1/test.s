	.cpu cortex-m0
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 1
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.code	16
	.file	"test.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.global	stop_light
	.code	16
	.thumb_func
	.type	stop_light, %function
stop_light:
.LFB0:
	.file 1 "test.c"
	.loc 1 23 0
	.cfi_startproc
	push	{r3, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	.cfi_offset 14, -4
	.loc 1 26 0
	ldr	r3, .L11
	ldr	r3, [r3]
	cmp	r3, #1
	beq	.L3
	cmp	r3, #2
	beq	.L4
	cmp	r3, #0
	bne	.L10
	.loc 1 28 0
	ldr	r0, .L11+4
	bl	puts
.LVL0:
	.loc 1 29 0
	ldr	r3, .L11
	ldr	r3, [r3, #4]
	add	r3, r3, #1
	cmp	r3, #4
	bgt	.L6
	ldr	r2, .L11
	str	r3, [r2, #4]
	b	.L1
.L6:
	.loc 1 30 0
	ldr	r3, .L11
	mov	r2, #0
	str	r2, [r3, #4]
	.loc 1 31 0
	mov	r2, #2
	str	r2, [r3]
	b	.L1
.L4:
	.loc 1 36 0
	ldr	r0, .L11+8
	bl	puts
.LVL1:
	.loc 1 37 0
	ldr	r3, .L11
	ldr	r3, [r3, #4]
	add	r3, r3, #1
	cmp	r3, #4
	bgt	.L8
	ldr	r2, .L11
	str	r3, [r2, #4]
	b	.L1
.L8:
	.loc 1 38 0
	ldr	r3, .L11
	mov	r2, #0
	str	r2, [r3, #4]
	.loc 1 39 0
	mov	r2, #1
	str	r2, [r3]
	b	.L1
.L3:
	.loc 1 44 0
	ldr	r0, .L11+12
	bl	puts
.LVL2:
	.loc 1 45 0
	ldr	r3, .L11
	ldr	r3, [r3, #4]
	add	r3, r3, #1
	cmp	r3, #1
	bgt	.L9
	ldr	r2, .L11
	str	r3, [r2, #4]
	b	.L1
.L9:
	.loc 1 46 0
	ldr	r3, .L11
	mov	r2, #0
	str	r2, [r3, #4]
	.loc 1 47 0
	str	r2, [r3]
	b	.L1
.L10:
	.loc 1 52 0
	ldr	r3, .L11
	mov	r2, #0
	str	r2, [r3]
	.loc 1 53 0
	str	r2, [r3, #4]
.L1:
	.loc 1 56 0
	@ sp needed
	pop	{r3, pc}
.L12:
	.align	2
.L11:
	.word	.LANCHOR0
	.word	.LC1
	.word	.LC3
	.word	.LC5
	.cfi_endproc
.LFE0:
	.size	stop_light, .-stop_light
	.align	2
	.global	main
	.code	16
	.thumb_func
	.type	main, %function
main:
.LFB1:
	.loc 1 58 0
	.cfi_startproc
	push	{r4, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 4, -8
	.cfi_offset 14, -4
.LVL3:
	.loc 1 59 0
	mov	r4, #0
.LVL4:
.L15:
	.loc 1 62 0
	bl	stop_light
.LVL5:
	.loc 1 63 0
	mov	r0, r4
	bl	inc
.LVL6:
	sub	r4, r0, #0
.LVL7:
	.loc 1 61 0
	cmp	r4, #35
	ble	.L15
	.loc 1 67 0
	mov	r0, #0
.LVL8:
	@ sp needed
.LVL9:
	pop	{r4, pc}
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"RED\000"
.LC3:
	.ascii	"GREEN\000"
	.space	2
.LC5:
	.ascii	"YELLOW\000"
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	state, %object
	.size	state, 4
state:
	.space	4
	.type	state_counter.4968, %object
	.size	state_counter.4968, 4
state_counter.4968:
	.space	4
	.text
.Letext0:
	.file 2 "<built-in>"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x183
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF17
	.byte	0x1
	.4byte	.LASF18
	.4byte	.LASF19
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF1
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF2
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF3
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF6
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF9
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF10
	.uleb128 0x4
	.byte	0x4
	.4byte	0x7f
	.uleb128 0x5
	.4byte	0x72
	.uleb128 0x6
	.4byte	.LASF20
	.byte	0x1
	.byte	0x1
	.byte	0x14
	.4byte	0xa3
	.uleb128 0x7
	.ascii	"RED\000"
	.sleb128 0
	.uleb128 0x8
	.4byte	.LASF11
	.sleb128 1
	.uleb128 0x8
	.4byte	.LASF12
	.sleb128 2
	.byte	0
	.uleb128 0x9
	.4byte	.LASF15
	.byte	0x1
	.byte	0x17
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x10b
	.uleb128 0xa
	.4byte	.LASF13
	.byte	0x1
	.byte	0x18
	.4byte	0x2c
	.uleb128 0x5
	.byte	0x3
	.4byte	state_counter.4968
	.uleb128 0xb
	.4byte	.LVL0
	.4byte	0x15c
	.4byte	0xe0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC1
	.byte	0
	.uleb128 0xb
	.4byte	.LVL1
	.4byte	0x15c
	.4byte	0xf7
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC3
	.byte	0
	.uleb128 0xd
	.4byte	.LVL2
	.4byte	0x15c
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC5
	.byte	0
	.byte	0
	.uleb128 0xe
	.4byte	.LASF21
	.byte	0x1
	.byte	0x3a
	.4byte	0x2c
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x14b
	.uleb128 0xf
	.ascii	"i\000"
	.byte	0x1
	.byte	0x3b
	.4byte	0x2c
	.4byte	.LLST0
	.uleb128 0x10
	.4byte	.LVL5
	.4byte	0xa3
	.uleb128 0xd
	.4byte	.LVL6
	.4byte	0x175
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x74
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0xa
	.4byte	.LASF14
	.byte	0x1
	.byte	0x15
	.4byte	0x2c
	.uleb128 0x5
	.byte	0x3
	.4byte	state
	.uleb128 0x11
	.4byte	.LASF16
	.byte	0x2
	.byte	0
	.4byte	.LASF22
	.4byte	0x2c
	.4byte	0x175
	.uleb128 0x12
	.4byte	0x79
	.byte	0
	.uleb128 0x13
	.ascii	"inc\000"
	.byte	0x1
	.byte	0xe
	.4byte	0x2c
	.uleb128 0x12
	.4byte	0x2c
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",%progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL3-.Ltext0
	.4byte	.LVL4-.Ltext0
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL4-.Ltext0
	.4byte	.LVL7-.Ltext0
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL7-.Ltext0
	.4byte	.LVL8-.Ltext0
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL8-.Ltext0
	.4byte	.LVL9-.Ltext0
	.2byte	0x1
	.byte	0x54
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF7:
	.ascii	"long long int\000"
.LASF0:
	.ascii	"unsigned int\000"
.LASF22:
	.ascii	"puts\000"
.LASF2:
	.ascii	"unsigned char\000"
.LASF21:
	.ascii	"main\000"
.LASF20:
	.ascii	"light_states\000"
.LASF16:
	.ascii	"__builtin_puts\000"
.LASF6:
	.ascii	"long unsigned int\000"
.LASF8:
	.ascii	"long long unsigned int\000"
.LASF17:
	.ascii	"GNU C 4.8.4 20140526 (release) [ARM/embedded-4_8-br"
	.ascii	"anch revision 211358] -mcpu=cortex-m0 -mthumb -g -O"
	.ascii	"1\000"
.LASF13:
	.ascii	"state_counter\000"
.LASF19:
	.ascii	"/u/mrlonis/C335-Fall2017/HW1\000"
.LASF12:
	.ascii	"GREEN\000"
.LASF10:
	.ascii	"char\000"
.LASF18:
	.ascii	"test.c\000"
.LASF5:
	.ascii	"long int\000"
.LASF15:
	.ascii	"stop_light\000"
.LASF11:
	.ascii	"YELLOW\000"
.LASF4:
	.ascii	"short unsigned int\000"
.LASF1:
	.ascii	"signed char\000"
.LASF14:
	.ascii	"state\000"
.LASF3:
	.ascii	"short int\000"
.LASF9:
	.ascii	"sizetype\000"
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 4.8.4 20140526 (release) [ARM/embedded-4_8-branch revision 211358]"
