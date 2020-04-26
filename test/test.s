	.file	"test.c"
	.option nopic
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	li	a0,1
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
