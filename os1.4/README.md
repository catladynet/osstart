# os
本节目标：加载ELF文件<br>

<h3>代码框架 Frame</h3>
<pre><code>
|---+bootloader             #引导程序
|   |---...
|---+utils
|   |---genBoot.pl          #生成引导程序
|   |---genKernel.pl        #生成内核程序
|---+kernel
|   |---main.c              #主函数
|   |---Makefile
|---Makefile</code></pre>

bootloader文件夹为第一扇区引导程序（bootsector），我们用它来加载kernel。

