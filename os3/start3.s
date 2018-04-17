.code16
.global start
start:
        movw %cs, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %fs
	movw %ax, %gs
	movw %ax, %ss
	movw $start, %sp

        xor %eax, %eax
        movw %cs, %ax
        shl $4, %eax
        add $LABEL_DESC_CODE32, %eax
        movw %ax, (LABEL_DESC_CODE32 + 2)
        shl $16, %eax
        movb %al, (LABEL_DESC_CODE32 + 4)
        movb %ah, (LABEL_DESC_CODE32 + 7)

        xor %eax, %eax
        movw %cs, %ax
        shl $4, %eax
        add $gdt, %eax
        movl %eax, (gdt + 2)

        data32 addr32 lgdt gdtDesc      #加载GDTR

        cli                             #关闭中断
        inb $0x92, %al                  #启动A20总线
        orb $0x02, %al
        outb %al, $0x92

        movl %cr0, %eax                 #启动保护模式
        orb $0x01, %al
        movl %eax, %cr0
        data32 ljmp $0x08, $start32     #长跳转切换至保护模式

.code32
start32:

        movw $SelectorVideo, %ax
	movw %ax, %gs
        movl $((80*5+0)*2), %edi                #在第5行第0列打印
        movb $0x0c, %ah                         #黑底红字
        movb $72, %al                           #72为H的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
1:      hlt
        jmp 1b        
        jmp bootMain                    #跳转至bootMain函数 定义于boot.c
.p2align 2
gdt:
        .word 0,0                       #GDT第一个表项必须为空
        .byte 0,0,0,0
LABEL_DESC_CODE32:
        .word 0xffff,0                  #代码段描述符
        .byte 0,0x9a,0xcf,0
        
        .word 0xffff,0                  #数据段描述符
        .byte 0,0x92,0xcf,0
LABEL_DESC_VIDEO:        
        .word 0xffff,0x8000             #视频段描述符
        .byte 0x0b,0x92,0xcf,0
.equ SelectorCode32, LABEL_DESC_CODE32 - gdt
.equ SelectorVideo, LABEL_DESC_VIDEO - gdt
gdtDesc:
	.word (gdtDesc - gdt -1)
	.long 0