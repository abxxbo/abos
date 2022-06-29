%macro printc 1
	mov ah, 0x0e
	mov al, %1
	int 0x10
%endmacro


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

printh:
    push ax
    push bx
    push cx

    mov ah, 0Eh

    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    mov cx, 4

    printh_loop:
        cmp cx, 0
        je printh_end

        push bx

        shr bx, 12

        cmp bx, 10
        jge printh_alpha

            mov al, '0'
            add al, bl

            jmp printh_loop_end

        printh_alpha:
            
            sub bl, 10
            
            mov al, 'A'
            add al, bl


        printh_loop_end:

        int 0x10

        pop bx
        shl bx, 4

        dec cx

        jmp printh_loop

printh_end:
    pop cx
    pop bx
    pop ax

    ret