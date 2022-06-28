shell:
	call get_char
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
		je read3rd

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
		.LoopH:
			mov byte [buffer+si], byte 0
			inc si
			cmp si, 128
			je shell
			jne .LoopH
		;; return
		jmp shell
	.Clear:
		;; scroll window
		mov ah, 0x07
		mov al, 0x00
		mov bh, 0xf
		mov ch, 0
		mov cl, 0
		mov dh, 80
		mov dl, 25
		int 0x10

		;; move cursor back up to 0,0
		mov ah, 0x02
		mov bh, 0
		mov dh, 0
		mov dl, 0
		int 0x10

		mov si, 0
		.Loop:
			mov byte [buffer+si], byte 0
			inc si
			cmp si, 128
			je shell
			jne .Loop

		jmp shell

clear_scr:

	;; other
	mov al, 0x03
	mov ah, 0
	int 0x10

	mov ah, 0x0b
	mov bh, 0x00
	mov bl, 0x9
	int 0x10
	jmp shell

help0: db `AbOS Help\r\nhelp --> This command\r\ncls  --> clear screen\r\nedit --> editor\r\nreadfrom3 --> read sector 3\r\n`, 0


;; applications to be executed
%include "apps/editor.asm"

buffer: times 128 db 0
cleared: times 128 db 0