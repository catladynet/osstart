.text                         #指明代码段
.global start                 #指明start段为全局段，可被其他找到
.code16                       #指明16位代码（实模式）
start:
        movw $0x0000, %ax     #屏幕清零
        int  $0x10            #中断调用
        movw $message, %bp    #字符串地址传送给bp
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
.org  0x1fe,0x90              #从第511个字节开始
.word 0xaa55                  #填充55和aa
#经过上面两行代码构造了一个完整的启动扇区
#bios识别启动磁盘第一个扇区（前512字节），最后两个字节为55和aa，则标志为一个可加载boot
