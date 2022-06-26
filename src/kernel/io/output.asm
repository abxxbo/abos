;; print a character to the screen
%macro printc 1
	mov ah, 0x0e
	mov al, %1
	int 0x10
%endmacro


;; write full string to screen
printf:
	push ax
	push bx

	mov ah, 0x0e
	.Loop:
		cmp [bx], byte 0
		je .Exit

		mov al, [bx]
		int 0x10
		inc bx
		jmp .Loop
	.Exit:
		pop ax
		pop bx
		ret