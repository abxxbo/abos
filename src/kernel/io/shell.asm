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
		mov bx, buffer
		call printf
		printc `\r`
		printc `\n`
		;; check if our buffer is equal to some of our commands
		cmp [buffer], dword "help"
		je commands.Help

		cmp [buffer], dword "clear"
		je commands.Clear

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
		movzx dh, bl
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

		jmp shell

help0: db `AbOS Help\r\nhelp --> This command\r\nclear --> clear screen\r\n`, 0

buffer: times 128 db 0