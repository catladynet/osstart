.code32

.global irqEmpty
irqEmpty:			//空函数，什么都不做
	pushl $0 // push dummy error code
	pushl $-1 // push interrupt vector into kernel
	pushal // push process state into kernel stack
	pushl %esp
	addl $4, %esp
	popal
	addl $4, %esp //interrupt vector is on top of kernel stack
	addl $4, %esp //error code is on top of kernel stack
	iret
