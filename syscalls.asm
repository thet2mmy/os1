	bits 16

print_string:
	pusha
	cli
	mov ah,0xE
.print_string_loop:
	lodsb
	or al,al
	jz .print_string_end
	int 0x10
	jmp .print_string_loop
.print_string_end:
	popa
	ret

newline:
	pusha
	mov ah,0xE
	mov al,0xD
	int 0x10
	mov al,0xA
	int 0x10
	popa
	ret

show_prompt:
	pusha
	call newline
	mov ah,0xE
	mov al,'#'
	int 0x10
	mov al,0x20
	int 0x10
	popa
	ret
