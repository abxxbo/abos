shell:
	call get_char
	mov cl, al
	cmp cl, 13
	je .Enter
	jne .Print

	.Enter:
		mov si, 0
		printc `\r`
		printc `\n`
		;; check if our buffer is equal to some of our commands
		cmp [buffer], dword "help"
		je commands.Help
		;; jump back
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

help0: db `AbOS Help\r\nhelp --> This command\r\n`, 0

buffer: times 128 db 0