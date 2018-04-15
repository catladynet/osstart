.text
.global start
.code16
start:
        movw $0x0000, %ax    #屏幕清零
        int  $0x10
        movw $message, %bp
        #movw %ax, %bp         #字符串地址传送给bp
        movw $13, %cx         #输出的消息有13个字符      
        movw $0x1301, %ax     #AH=0x13 打印字符串                  
        movw $0x000c, %bx     #BH=0x00 黑底 BL=0x0c 红字           
        movw $0x0000, %dx     #在第0行0列开始打印             
        int  $0x10  
l:      hlt
        jmp l                 #无限循环
message: 
        .string "Hello, World!\0"
#.org new-lc,fill:从new-lc标识的新位置开始存放下边的代码或数据，之前空出来的空间用fill填充
.org  0x1fe,0x90
.word 0xaa55
