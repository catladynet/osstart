# OS
a simple os boot sector<br>
在代码所在目录下终端下运行：<br>
$ make<br>
然后运行：<br>
$ make play<br>
即可展示一个最简单的操作系统<br>
其实这只是一个实模式下的引导扇区（boot sector）<br>
实现了在实模式下打印Hello，world！<br>

#### 计算机开机
在计算机刚开机时，计算机由固化在主板中的BIOS控制<br>
BIOS从磁盘取出第一个扇区（0号扇区），如果该扇区以55、aa结尾，则识别该扇区为引导扇区<br>
该引导扇区的作用是加载内核<br>
本次实验我们用该引导扇区实现一个简单的功能，并未做更多的事<br>

#### BIOS中断例程
当然开机时计算机还运行在16位实模式的时候，我们可以使用BIOS提供的中断例程，例如在80386的bios中，int$10可以对屏幕打印相关的操作，int$13可以对磁盘相关的操作等等。

#### 关于makefile：
maekfile文件是终端命令的一个集合，帮助我们批量编译程序<br>
观察本次项目中的makefile文件，写了四个操作<br>
终端使用命令make，则默认执行第一个操作<br>
终端使用命令make play，执行第二个操作play<br>
以此类推，make clean就是清除缓存等等<br>

#### 查看内存布局
使用命令：<br>
~ objdump -S -l -z -x start.elf > a<br>
可以将该系统的内存布局打印为txt格式查看<br>

#### 调试方法
gdb+qemu调试指令：<br>
$ make debug<br>
然后另开一个终端，输入：<br>
$ gdb<br>
接着在gdb中依次输入：<br>
$ target remote:1234<br>
$ break *0x7c00<br>
$ continue<br>
显示汇编<br>
$ layout asm<br>
显示寄存器信息<br>
$ layout r<br>
单步执行<br>
$ si<br>

#### 关于AT&T汇编和Intel汇编
本篇采用AT&T汇编，其为GNU/linux世界通用标准，文件后缀.s，可以用gcc直接编译<br>
但是网上大量汇编参考代码为Intel标准，文件后缀.asm适合在windows下开发<br>
两者语法有大量不同之处，熟练后可以相互转化<br>
