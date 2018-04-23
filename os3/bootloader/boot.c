#include "boot.h"
#define SECTSIZE 512

void bootMain(void) {
	/*观察app里的makefile文件，可以看到将start程序段写到了从0x8c00位置开始处。
	0x8c00表示程序的线性地址空间，但是未加载前，这段代码存储在磁盘中。
	开机时只有磁盘第一个扇区（0号扇区）——也就是启动扇区，被装载到内存。
	一个扇区512字节，start程序段被编译到了紧接着启动扇区的第二个扇区（1号扇区）。
	本段程序的作用是将app中的start程序段从磁盘装载到内存里运行*/
	unsigned int sceno = 1;			//设置要读写的磁盘扇区号为1，即第二个磁盘扇区
	unsigned long va = 0x8c00;		//设置要写入的内存地址为0x8c00
	readSect((void*)va, sceno);
	
	asm volatile("jmp 0x8c00");		//跳转到刚刚写入代码的位置执行
	while(1);						//无限循环
}

void waitDisk(void) { // waiting for disk
	while((inByte(0x1F7) & 0xC0) != 0x40);
}

//其中*dst为要写入的内存地址，offset为磁盘扇区号
void readSect(void *dst, int offset) { // reading one sector of disk
	int i;
	waitDisk();
	outByte(0x1F2, 1);
	outByte(0x1F3, offset);
	outByte(0x1F4, offset >> 8);
	outByte(0x1F5, offset >> 16);
	outByte(0x1F6, (offset >> 24) | 0xE0);
	outByte(0x1F7, 0x20);

	waitDisk();

	for (i = 0; i < SECTSIZE / 4; i ++) {//一个扇区512字节，每次inlong读取4个字节写入内存
		((int *)dst)[i] = inLong(0x1F0);
	}
}
