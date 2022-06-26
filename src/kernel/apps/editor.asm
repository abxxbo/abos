;; AbOS editor
editor:
	;; clear screen and
	;; change palette
	call set_colors
	;; write title bar
	call make_titlebar

	mov si, 0

	.MainLoop:
		call get_char
		mov cl, al
		cmp cl, 0x1157	;; Shift+W
		je exit_screen

		mov ah, 0x0e
		mov al, cl
		int 0x10
		;; add to buffer
		mov byte [editor_buffer+si], byte cl
		inc si


		;; something
		jmp .MainLoop


exit_screen:
	;; do some stuff
	printc `\r`
	printc `\n`
	;; ask user where they
	;; would like to save file
	mov bx, storage_q
	call printf

	mov si, 0
	.Loop:
		call get_char
		mov cl, al
		cmp cl, 13
		je .Exit

		cmp cl, 'y'
		je write3rd

		mov ah, 0x0e
		mov al, cl
		int 0x10


		mov byte [storage_buf+si], byte cl

		jmp .Loop
	.Exit:
		printc `\r`
		printc `\n`

		;; clear screen / scroll down a page
		mov bx, lotsoflines
		call printf
		mov bx, lotsoflines
		call printf

		mov ah, 0x02
		mov bh, 0
		mov dh, 0x00
		mov dl, 0x00
		int 0x10

		;; clear command buffer
		;; so that editor will not
		;; be relaunched on exit
		mov si, 0
		jmp .KillBuffer
		ret

	.KillBuffer:
		mov byte [buffer+si], byte 0
		inc si
		cmp si, 128
		je shell
		jne .KillBuffer

	jmp $

read3rd:
	pusha
	mov ah, 0x02
	mov dl, 0x80 ;; 0x00 -> floppy, NOT HDD
	mov ch, 0x00 ;; first cyl
	mov dh, 0x00 ;; first head
	mov al, 1		 ;; no. of sect
	mov cl, 3		 ;; 3rd sector
	
	push bx
	mov bx, 0
	mov es, bx	;; reset
	pop bx
	mov bx, 0x8000
	int 0x13

	jc disk_err
	popa
	mov bx, 0x8000
	call printf
	jmp exit_screen.KillBuffer
	ret

disk_err:
	int 19h
	ret

write3rd:
	pusha
	mov ah, 0x03
	mov dl, 0x80
	mov ch, 0x00
	mov dh, 0x00
	mov al, 1
	mov cl, 3

	push bx
	mov bx, 0
	mov es, bx
	pop bx
	mov bx, editor_buffer
	int 0x13

	jc disk_err
	jmp exit_screen.KillBuffer
	ret

set_colors:
	mov al, 0x03
	mov ah, 0
	int 0x10

	mov ah, 0x0b
	mov bh, 0x00
	mov bl, 0x1
	int 0x10
	ret

make_titlebar:
	mov ah, 0x09
	mov al, ' '
	mov bh, 0x00
	mov bl, 0x8f
	mov cx, 80
	int 0x10
	
	mov bx, spaces_titlebar
	call printf

	mov bx, titlebar
	call printf

	;; move cursor back down 1 line
	mov ah, 0x02
	mov bh, 0x00
	mov dl, 0x00
	mov dh, 1
	int 0x10
	ret

titlebar: db 'AbEdit', 0
spaces_titlebar: db '                                     ', 0

editor_buffer: times 1024 db 0

storage_buf: times 1 db 0
storage_q: db 'Save to 3rd sector (Overwrites anything else)? ', 0
storage_saving: db `I am saving this buffer to: `, 0

lotsoflines:
	db `\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r`, 0