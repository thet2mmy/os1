	org 0x7c00
	bits 16

; +++++++++++++++++++++++++++++++++
; main source code file for os_1!!!
; +++++++++++++++++++++++++++++++++

; this file should have been loaded from
; boot.asm

begin:
	; show our boot message
	; ensure that the user knows the kernel booted properly
	mov si, boot_msg
	call print_string
	call show_prompt
	
main:
	
	; get 1 character from keyboard
	; store last char
	mov [k_buf], al
	mov ah,0x0
	int 0x16

	; echo the last character
	mov ah,0xE
	int 0x10

	; if it's a CR then check the last key for the command to run
	cmp al,0xD
	jz  .commands

	; loop back to the main loop's beginning
	jmp main

.commands:
	; this routine will run when the user
	; pushes the RETURN key (0xD, CR or carraige return)

	call newline
	cmp byte [k_buf],'k'
	jz  .command_kversion

	cmp byte [k_buf],'b'
	jz  .command_bversion

.commands_end:
	; return to the main routine
	call show_prompt
	jmp main

.command_bversion:
	pusha
	mov si, bootloader_version	
	call print_string
	jmp .commands_end

.command_kversion:
	; this routine is run to print the kernel version
	mov si, boot_msg
	call print_string
	jmp .commands_end

; +++++++++++++++++++++++++++++++++++++++++++++++++++++++
%include 'syscalls.asm'
; make sure that all syscalls are available for this file

boot_msg:
	db "OS_1 0.3.0 kernel", 0xD, 0xA, 0x0
bootloader_version:
	db "Bootloader version 0.1.0 (Adapted from code by Ciro Santilli)", 0xD, 0xA, 0x0
k_buf:
	db 0x0
