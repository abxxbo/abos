%macro get_char 0
	xor ax, ax
	mov ah, 0x00
	int 0x16
%endmacro

%macro write_prompt 0
	printc `#`
	printc ` `
%endmacro

shell:
	get_char
	mov cl, al
	cmp cl, 13
	je .Enter

	cmp cl, 08
	je .Backspace
	jne .Print
	.Enter:
		mov si, 0
		printc `\r`
		printc `\n`
		;; check if our buffer is equal to some of our commands
		cmp [buffer], dword "help"
		je commands.Help

		cmp [buffer], dword "cls"
		je clear_scr

		cmp [buffer], dword "edit"
		je editor

		cmp [buffer], dword "read"
		je invoke_read3rd

		write_prompt

		;; jump back
		jmp shell
	.Backspace:
		dec si
		mov byte[buffer+si], byte `\0`

		;; get current cursor position
		mov ah, 0x03
		mov bh, 0
		int 0x10

		mov ch, dl
		mov bl, dh
		dec ch

		cmp dl, 3
		jl shell

		;; move cursor
		mov ah, 0x02
		mov bh, 0
		mov dl, ch
		mov dh, bl
		int 0x10

		jmp shell
	.Print:
		printc cl
		
		;; add CL to buffer
		mov byte [buffer+si], byte cl
		inc si

		;; Loop!
		jmp shell

commands:
	.Help:
		mov bx, help0
		call printf

		mov si, 0
		write_prompt
		.LoopH:
			mov byte [buffer+si], byte 0
			inc si
			cmp si, 128
			je shell
			jne .LoopH
		;; return
		jmp shell
	ret

clear_scr:
	;; video mode
	mov al, 0x03
	mov ah, 0
	int 0x10

	write_prompt
	jmp shell

%include "fs/fs.asm"

invoke_read3rd:
	read_sector 1, 3, read_buffer

	mov bx, read_buffer
	call printf
	printc `\r`
	printc `\n`
	write_prompt
	;; clear buffer
	.Loop:
		mov byte [buffer+si], byte 0
		inc si
		cmp si, 128
		je shell
		jne .Loop
	ret

;; data
help0: db `AbOS Help\r\nhelp --> This command\r\ncls  --> clear screen\r\nedit --> editor\r\nread --> read sector 3\r\n`, 0

%include "editor.asm" ;; applications to be executed

buffer: times 128 db 0
cleared: times 128 db 0
