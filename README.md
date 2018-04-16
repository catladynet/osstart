# osstart
a simple os boot sector<br>
在终端下运行：<br>
$ make<br>
然后运行：<br>
$ make play<br>
即可展示一个最简单的操作系统<br>

#### 编译环境
$sudo apt-get update<br>
$sudo apt-get install qemu-system-x86<br>
$sudo apt-get install vim<br>
$sudo apt-get install gcc<br>
$sudo apt-get install gdb<br>
$sudo apt-get install binutils<br>
$sudo apt-get install make<br>
$sudo apt-get install perl<br>

#### 关于makefile：
maekfile文件是终端命令的一个集合，帮助我们批量编译程序<br>
观察本次项目中的makefile文件，写了四个操作<br>
终端使用命令make执行第一个操作<br>
终端使用命令make play执行第二个操作<br>
以此类推，make clean就是清除缓存等等<br>

#### 关于AT&T汇编和Intel汇编
本篇采用AT&T汇编，其为GNU/linux世界通用标准，文件后缀.s，可以用gcc直接编译<br>
但是网上大量汇编参考代码为Intel标准，文件后缀.asm适合在windows下开发<br>
两者语法有大量不同之处，熟练后可以相互转化<br>
