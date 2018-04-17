        jmp start
.text
.code16
.macro .desc base, limit, attr
.word (\limit) & 0xFFFF
.word (\base) & 0xFFFF
.byte ((\base) >> 0x10) & 0xFF
.word (((\limit) >> 0x08) & 0x0F00) | ((\attr) & 0xF0FF)
.byte ((\base) >> 0x18) & 0xFF
.endm
.global start
start:
        mov %cs, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs
        mov %ax, %ss
        mov $start, %sp
        lgdt gdt_ptr
        cli
        in $0x92, %al
        or $0x02, %al
        out %al, $0x92
        mov %cr0, %eax
        or $0x01, %al
        mov %eax, %cr0
        ljmpl $0x08, $0x00
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
        movl $((80*5+0)*2), %edi                #在第5行第0列打印
        movb $0x0c, %ah                         #黑底红字
        movb $72, %al                           #72为H的ASCII码
        movw %ax, %gs:(%edi)                    #写显存   

        jmp bootMain 
1:      hlt
        jmp 1b   

.equ _start32_length, . - start32 - 1
