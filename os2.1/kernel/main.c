#include "common.h"
#include "x86.h"
#include "device.h"

void kEntry(void) {

	initSerial();// initialize serial port
	//定义在kernel/serial.c中，用来初始化一些特定端口的值

	initIdt(); // initialize idt
	//定义在kernel/idt.c中

	initIntr(); // iniialize 8259a
	//定义在kernel/i8259.c中

	while(1);
	assert(0);
}
