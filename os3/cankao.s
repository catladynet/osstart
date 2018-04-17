.text
.code16
.macro .desc base, limit, attr
.word (\limit) & 0xFFFF
.word (\base) & 0xFFFF
.byte ((\base) >> 0x10) & 0xFF
.word (((\limit) >> 0x08) & 0x0F00) | ((\attr) & 0xF0FF)
.byte ((\base) >> 0x18) & 0xFF
.endm
.global _start
_start:
mov %cs, %ax
mov %ax, %ds
mov %ax, %es
mov %ax, %fs
mov %ax, %gs
mov %ax, %ss
mov $_start, %sp
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
.code32
_start32:
.equ _start32_offset, . - _start + 0x7C00
mov $0x10, %ax
mov %ax, %es
mov $0x1F201F20, %eax
xor %edi, %edi
mov $2000, %ecx
rep stosl
jmp .
.equ _start32_length, . - _start32 - 1
.org 0x01FE
.word 0xAA55.text
.code16
.macro .desc base, limit, attr
.word (\limit) & 0xFFFF
.word (\base) & 0xFFFF
.byte ((\base) >> 0x10) & 0xFF
.word (((\limit) >> 0x08) & 0x0F00) | ((\attr) & 0xF0FF)
.byte ((\base) >> 0x18) & 0xFF
.endm
.global _start
_start:
mov %cs, %ax
mov %ax, %ds
mov %ax, %es
mov %ax, %fs
mov %ax, %gs
mov %ax, %ss
mov $_start, %sp
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
.code32
_start32:
.equ _start32_offset, . - _start + 0x7C00
mov $0x10, %ax
mov %ax, %es
mov $0x1F201F20, %eax
xor %edi, %edi
mov $2000, %ecx
rep stosl
1:
hlt
jmp 1b
.equ _start32_length, . - _start32 - 1
.org 0x01FE
.word 0xAA55