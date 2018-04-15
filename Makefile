bootloader.bin: start.s
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