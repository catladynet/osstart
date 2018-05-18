#os11
<br>
本实验我们需要建立进程的概念。
进程在系统中由进程描述符识别，定义在memory.h中：
<code>
struct ProcessTable{
	struct TrapFrame *tf;
	int state;
	int timeCount;
	int sleepTime;
	uint32_t pid;
	uint32_t stack[MAX_STACK_SIZE];
};
struct ProcessTable pcb[MAX_PCB_NUM];       //共建立20个进程描述符
</code>


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