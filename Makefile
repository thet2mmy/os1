boot:
	nasm -f bin boot.asm -o os_1.bin
	qemu-system-i386 os_1.bin
