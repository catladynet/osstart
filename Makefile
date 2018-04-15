start.img: start.s
	#编译生成.o文件
	gcc -c -m32 start.s -o start.o								 
	#将start.s文件中标志为start代码放在0x7c00处开始，生成elf格式文件	 
	ld -m elf_i386 -e start -Ttext 0x7c00 start.o -o start.elf
	#编译生成.bin文件
	objcopy -S -j .text -O binary start.elf start.bin			 
	#得到img镜像文件，用于启动加载
	cat start.bin > start.img									 

clean:
	rm -rf *.o *.elf *.bin *.img

play:
	qemu-system-i386 start.img

debug:
	qemu-system-i386 -s -S start.img