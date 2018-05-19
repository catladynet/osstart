# os
本节目标：初始化中断描述符表<br>

中断描述符表IDT和GDT类似，芯片通过一个特定寄存器idtr保存IDT表的初始物理地址。因此中断描述符表可以放在内存的任意位置，使用汇编指令lidt可以将中断表的物理地址保存到idtr寄存器。

intel芯片定义一个8位的中断向量来标志各种中断信号，也就是0到255号中断。当芯片遇到第n号中断信号的时候，内核根据寄存器idtr中保存的IDT表地址，从IDT中取出第n个描述符，执行该描述符的中断处理过程。

IDT中共需要设置256个中断描述符，每项描述符占8字节，这8个字节中包含段选择符、偏移量和特权字段等。

在内核遇到第n号中断之后，根据第n项中断描述符中的段选择符和偏移量，去查找GDT，得出中断处理例程的地址。再检查字段特权级，如果符合权限要求，就开始进行现场保护，执行中断例程。

内核在工作前，要对IDT中这256项描述符进行初始化。当开机时计算机还运行在16位实模式的时候，IDT表其实已经被BIOS初始化并可以使用，比如80386的bios中断中，int$10可以对屏幕打印相关的操作，int$13可以对磁盘相关的操作。因为启动扇区必须是磁盘第一个扇区，只有512字节，这些BIOS中断有助于我们在启动扇区可以进行各种初始化，方便快速装载我们的内核。

当跳入保护模式，内核接管计算机的时候，我们就不能使用BIOS提供的中断服务例程了。我们需要自己在内存中开辟一块区域，进行IDT表的二次初始化。一般先进行预初始化，对256个中断描述符，先用一个统一的中断门填充，这个中断门指向一个进行空操作的中断处理程序，这样可以防止遇到不可知的中断时内核崩溃。然后我们再进行第二遍初始化，填充那些有意义的中断门或者陷阱门。

对于硬件中断，我们在驱动程序中进行初始化的时候，要做到硬件发出的中断信号IRQ线与一个具体的中断向量对应，并且使该中断处理例程绑定该中断向量。这样在将来处理中断的时候，一个具体IRQ线发出的中断信号才能被某个中断处理程序识别并接管。


本节我们用c语言和内联汇编相结合的方式，实现在内核代码中初始化中断描述符表。


<h3>代码框架 Frame</h3>
<pre><code>
|---+bootloader             #引导程序
|   |---...
|---+utils
|   |---genBoot.pl          #生成引导程序
|   |---genKernel.pl        #生成内核程序
|---+kernel
|   |---+include            #头文件
|   |---+kercode            #内核代码
|   |   |---i8259.c         #重设主从8259A
|   |   |---idt.c           #初始化中断描述表
|   |   |---serial.c        #初始化串口输出
|   |---+lib
|   |---main.c              #主函数
|   |---Makefile
|---Makefile</code></pre>

bootloader文件夹为第一扇区引导程序（bootsector），我们用它来加载kernel。
kernel文件夹为内核代码区，分为include头文件夹、kernel内核主要代码文件夹、lib库函数文件夹以及main.c主程序代码。
本节实验只需关注kernel文件夹。
阅读顺序：main.c -> kercode/idt.c -> include
main.c中使用的函数定义在kercode中。
通用的函数、封装汇编代码的函数、全局常量和数据结构 定义在头文件include中。
include惯例如下：include文件主目录下每一个.h文件对应一个同名文件夹，主目录的.h文件通过include方式对同名文件夹下的.h文件进行封装。具体可查阅kernel/include/common.h文件。
<h4>include代码框架 Frame</h4>
<pre><code>
|---+include            
|   |---+common
|   |   |---assert.h        #断言函数
|   |   |---const.h         #常用常量
|   |   |---types.h         #常用数据类型
|   |---+device
|   |   |---serial.h        #定义端口号常量
|   |---+x86
|   |   |---cpu.h           #cpu相关内联汇编：修改idt、开关中断
|   |   |---io.h            #读写端口的内联汇编、ELF文件数据结构
|   |   |---irq.h           #中断相关
|   |   |---memory.h
|   |---common.h         #常用
|   |---device.h         #设备相关
|   |---x86.h            #x86指令体系相关，包括数据结构、内联汇编
</code></pre>