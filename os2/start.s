.text
.code16

/*.macro .endm为汇编宏指令，本段宏指令用于gdt数据的排版
.desc为宏指令名
base，limit，attr为输入数据，以下几行皆为为数据处理和排版安排*/
.macro .desc base, limit, attr
.word (\limit) & 0xFFFF
.word (\base) & 0xFFFF
.byte ((\base) >> 0x10) & 0xFF
.word (((\limit) >> 0x08) & 0x0F00) | ((\attr) & 0xF0FF)
.byte ((\base) >> 0x18) & 0xFF
.endm

.global start
start:
        #初始化，调试的时候看来好像不需要这些
        /*
        mov %cs, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss
        mov $start, %sp
        */

        # 清屏
        movw    $0x02, %ax
        int     $0x10

        #加载gdt_ptr的地址到控制寄存器gdtr中，该寄存器用来存放GDT在主存中的地址和大小
        #由于我们已经讲gdt的结构全部安排好，只需要直接加载地址即可
        lgdt gdt_ptr    

        /*本操作用于关中断：
        上面用到的int $0x10属于BIOS中断服务，而BIOS的中断服务例程都是针对16位实模式，只在开机时候用一用。
        跳入保护模式之后，权利交给操作系统，我们就不能用BIOS提供的中断服务了，而要重新写操作系统自己的中断服务例程*/
        cli

        in $0x92, %al
        or $0x02, %al
        out %al, $0x92
        mov %cr0, %eax
        or $0x01, %al
        mov %eax, %cr0

        /*ljmp $0x8, $protcseg 
        用0x8作为段选择符，到GDT中去取出偏移为[0x8]的值，
        #再加上偏移量$protcseg. 跳转到gdt[0x8] + $protcseg的地址处执行。*/
        ljmpl $0x08, $0x00

/*本节为GDT表，关于GDT详细论述看readme*/
gdt_null:
        .desc 0, 0, 0
gdt_code:
        .desc _start32_offset, _start32_length, 0x4098
gdt_video:
        .desc 0xB8000, 0xFFFF, 0x92
gdt_ptr:
        .word . - gdt_null - 1
        .long gdt_null
.equ SelectorVideo, gdt_video - gdt_null

.code32
start32:
.equ _start32_offset, . - start + 0x7C00

        movw $SelectorVideo, %ax
	movw %ax, %gs
        movl $((80*3+0)*2), %edi                #在第3行第0列打印
        movb $0x0c, %ah                         #黑底红字
        movb $72, %al                           #72为H的ASCII码
        movw %ax, %gs:(%edi)                    #写显存   
        movl $((80*3+1)*2), %edi                #在第3行第1列打印
        movb $101, %al                          #101为e的ASCII码
        movw %ax, %gs:(%edi)  
        movl $((80*3+2)*2), %edi                #在第3行第2列打印
        movb $108, %al                          #108为l的ASCII码
        movw %ax, %gs:(%edi)  
        movl $((80*3+3)*2), %edi                #在第3行第3列打印
        movb $108, %al                          #108为l的ASCII码
        movw %ax, %gs:(%edi)  
        movl $((80*3+4)*2), %edi                #在第3行第4列打印
        movb $111, %al                          #111为o的ASCII码
        movw %ax, %gs:(%edi)  
1:      hlt
        jmp 1b   

.equ _start32_length, . - start32 - 1

.org  0x1fe,0x90          
.word 0xaa55                  