#include "boot.h"
#include <string.h>

#define SECTSIZE 512

void bootMain(void) {
	/* 加载内核至内存，并跳转执行 */
	void (*p_kern)();
	int SectNum = 200;					//内核代码占200个扇区
	int KernelSize = SECTSIZE * SectNum;//内核大小512×200*
	unsigned char buf[KernelSize];		//用数组装下内核代码
	//unsigned int sceno = 1;				//设置要读写的磁盘扇区号为1，即第二个磁盘扇区
	for(int i=0; i<SECTSIZE ;++i){
		readSect(buf + i * SECTSIZE , i+1);
	}
	struct ELFHeader *elf = (void *)buf;
	struct ProgramHeader *ph = (void *)elf + elf->phoff;
	for(int i = elf->phnum; i > 0; --i){
		memcpy((void *)ph->vaddr, buf + ph->off, ph->filesz);
		memset((void *)ph->vaddr + ph->filesz, 0, ph->memsz -ph->filesz);
		ph = (void *)ph + elf->phentsize;
	}
	p_kern = (void *)elf->entry;		//空函数指向内核代码入口地址
	p_kern();							//跳转到入口地址执行
}

void waitDisk(void) { // waiting for disk
	while((inByte(0x1F7) & 0xC0) != 0x40);
}

void readSect(void *dst, int offset) { // reading a sector of disk
	int i;
	waitDisk();
	outByte(0x1F2, 1);
	outByte(0x1F3, offset);
	outByte(0x1F4, offset >> 8);
	outByte(0x1F5, offset >> 16);
	outByte(0x1F6, (offset >> 24) | 0xE0);
	outByte(0x1F7, 0x20);

	waitDisk();
	for (i = 0; i < SECTSIZE / 4; i ++) {
		((int *)dst)[i] = inLong(0x1F0);
	}
}
