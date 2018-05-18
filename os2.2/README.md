# os
<br>
接下来代码框架中，再次分出两个文件夹：kernel和app。
kernel为内核代码，app为用户程序。

<h3>代码框架 Frame</h3>
<pre><code>
|---+bootloader             #引导程序
|   |---...
|---+utils
|   |---genBoot.pl          #生成引导程序
|   |---genKernel.pl        #生成内核程序
|---+kernel
|   |---+include            #头文件
|   |---+kernel             #内核代码
|   |   |---doIrq.S         #中断处理
|   |   |---i8259.c         #重设主从8259A
|   |   |---idt.c           #初始化中断描述表
|   |   |---irqHandle.c     #中断处理函数
|   |   |---kvm.c           #初始化 GDT 和加载用户程序
|   |   |---serial.c        #初始化串口输出
|   |---+lib
|   |---main.c              #主函数
|   |---Makefile
|---+app                    #用户代码
|   |---main.c              #主函数
|   |---Makefile
|---+lib                    #库函数
|   |---lib.h
|   |---types.h
|   |---syscall.c           #系统调用入口
|---Makefile</code></pre>