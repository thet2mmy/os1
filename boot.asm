; thank you Ciro Santilli on github for this really simple
; bootloader; i have adapted it for OS_1

; adapted from here:
; https://github.com/cirosantilli/x86-bare-metal-examples/blob/1f6af9021283dc01f2247efbb6aa9217363fbf07/nasm/bios_disk_load.asm

org 0x7C00

start:
	jmp boot_begin

boot_begin:
	mov ah,0xE
	mov al,'.'
	int 0x10
	mov al,0xD
	int 0x10
	mov al,0xA
	int 0x10

	; load stage2 from disk
	mov ah, 0x02
	mov al, 1
	mov dl, 0x80
	mov ch, 0
	mov dh, 0
	mov cl, 2
	mov bx, begin
	int 0x13

	; jump to it
	jmp begin
	
	times ((0x200 - 2) - ($ - $$)) db 0x00
	dw 0xAA55

%include 'os_1.asm'
