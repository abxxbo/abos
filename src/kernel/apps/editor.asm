;; AbOS editor
editor:
	;; clear screen and
	;; change palette
	call set_colors
	call make_titlebar

	;; write title bar
	.MainLoop:
		;; something
		jmp .MainLoop


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