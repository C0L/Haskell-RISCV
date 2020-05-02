	.equ	FP_OFFSET,-16
	.equ	LOCAL_VARS,-40
	.text
	.align	1
	.globl	main
main:
	addi	sp,sp,LOCAL_VARS
	addi	sp,sp,FP_OFFSET
	sw	fp,0(sp)
	sw	ra,8(sp)
	li	x5,0x0
	sw	x5,16(sp)
	li	x5,0x1
	sw	x5,24(sp)
	li	x5,0x2
	sw	x5,32(sp)
	li	x5,0x3
	sw	x5,40(sp)
	li	a0,9000
	lw	fp,8(sp)
	lw	ra,16(sp)
	addi	sp,sp,-LOCAL_VARS
	addi	sp,sp,-FP_OFFSET
	jr	ra

