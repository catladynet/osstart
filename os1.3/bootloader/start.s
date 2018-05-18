.text
.code16
.global start                           #global能让编译器能识别到过程块start
start:
        movw $0x0000, %ax               #屏幕清零
        int  $0x10                      #中断调用
        cli                             #关闭中断
        inb $0x92, %al                  #启动A20总线
        orb $0x02, %al
        outb %al, $0x92
        data32 addr32 lgdt gdtDesc      #加载GDTR
        movl %cr0, %eax                 #启动保护模式
        orb $0x01, %al
        movl %eax, %cr0
        data32 ljmp $0x08, $start32     #长跳转切换至保护模式

.code32
start32:
        movw $SelectorCode, %ax
	movw %ax, %es
        movw %ax, %fs
        movw $SelectorData, %ax
        movw %ax, %ds                   #初始化es，fs，ds等

        movw $SelectorVideo, %ax        #设置视频段寄存器，指向视频段描述符
	movw %ax, %gs
          
        jmp bootMain                    #跳转至bootMain函数 定义于boot.c

gdt:
        .word 0,0                       #GDT第一个表项必须为空
        .byte 0,0,0,0
gdt_code:
        .word 0xffff,0                  #代码段描述符
        .byte 0,0x9a,0xcf,0
gdt_data:       
        .word 0xffff,0                  #数据段描述符
        .byte 0,0x92,0xcf,0
gdt_video:        
        .word 0xffff,0x8000             #视频段描述符
        .byte 0x0b,0x92,0xcf,0

gdtDesc:
        .word (gdtDesc - gdt -1)
        .long gdt
.equ SelectorCode,  gdt_code  - gdt     #代码段选择子
.equ SelectorData,  gdt_code  - gdt     #数据段选择子
.equ SelectorVideo, gdt_video - gdt     #视频段选择子