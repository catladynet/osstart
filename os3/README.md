# os3
第三个任务：在保护模式中加载一个磁盘中的程序<br>

<h3>代码框架 Frame</h3>
<pre><code>
|---+bootloader
|   |---boot.h                          #磁盘I/O接口
|   |---boot.c                          #加载磁盘上的用户程序
|   |---start.s                         #引导程序
|   |---Makefile
|---+utils
|   |---genboot.pl                      #生成MBR
|---+app
|   |---app.s                           #用户程序
|   |---Makefile
|---Makefile</code></pre>

如上所示，代码框架已和前面的实验完全不同。<br>
我们分出两个文件夹：<br>
bootloader为第一个引导扇区，目的是为了从磁盘中复制一个程序并执行；<br>
app为第二个扇区，执行打印的任务。<br>