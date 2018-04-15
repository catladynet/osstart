start.img: start.s
	gcc -c -m32 start.s -o start.o								  
	ld -m elf_i386 -e start -Ttext 0x7c00 start.o -o start.elf
	objcopy -S -j .text -O binary start.elf start.bin			 
	cat start.bin > start.img									 

clean:
	rm -rf *.o *.elf *.bin *.img

play:
	qemu-system-i386 start.img

debug:
	qemu-system-i386 -s -S start.img

	#start.img注释说明
	#1，编译生成.o文件
	#2，将start.s文件中标志为start代码放在0x7c00处开始，生成elf格式文件
	#3，编译生成.bin文件
	#4，得到img镜像文件，用于启动加载