osstart
=======
a simple os boot sector<br>
在终端下运行：<br>
~/working/ost$ make<br>
然后运行：<br>
~/working/ost$ make play<br>
即可展示一个最简单的操作系统<br>
其实这只是一个实模式下的引导扇区（boot sector）<br>
<br>
关于makefile：<br>
maekfile文件是终端命令的一个集合，帮助我们批量编译程序<br>
观察本次项目中的makefile文件，写了四个操作<br>
终端使用命令make执行第一个操作<br>
终端使用命令make play执行第二个操作<br>
以此类推，make clean就是清除缓存等等<br>
