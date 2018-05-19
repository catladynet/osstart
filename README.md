# OSstart
本项目是操作系统入门，最终实现一个简单的操作系统<br>
分为若干章节，循序渐进<br>
每章节实现一个总体目标，章节里每一小节增加一小部分内容<br>
查看每个文件夹的教程README<br>


### Chapter 1 保护模式
主要内容：保护模式、全局描述符表、加载磁盘文件<br>
------ [OS1.1](https://github.com/catladynet/osstart/tree/master/os1.1) ： 实模式<br>
------ [OS1.2](https://github.com/catladynet/osstart/tree/master/os1.2) ： 跳入保护模式<br>
------ [OS1.3](https://github.com/catladynet/osstart/tree/master/os1.3) ： 加载磁盘映像到内存<br>
------ [OS1.4](https://github.com/catladynet/osstart/tree/master/os1.4) ： 初探ELF文件<br>

### Chapter 2 中断
主要内容：中断描述符表、系统调用<br>
------ [OS2.1](https://github.com/catladynet/osstart/tree/master/os2.1) 初始化中断描述符表<br>



#### 实验环境
自制OS的CPU：Intel 80386<br>
模拟80386平台的虚拟机： QEMU<br>
交叉编译的编译器： GCC<br>
调试工具：GDB<br>
QEMU，GCC，GDB的运行平台： Linux<br>
编程语言： C，x86 Assembly<br>
汇编采用AT&T汇编，其为GNU/linux世界通用标准，文件后缀.s，可以用gcc直接编译<br>
$sudo apt-get update<br>
$sudo apt-get install qemu-system-x86<br>
$sudo apt-get install vim<br>
$sudo apt-get install gcc<br>
$sudo apt-get install gdb<br>
$sudo apt-get install binutils<br>
$sudo apt-get install make<br>
$sudo apt-get install perl<br>


