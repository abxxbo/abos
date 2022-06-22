;; A primitive GUI of sorts

StartGUI__:
	;; Initialize some things
	call clear
	call writeTitleBar

	;; Event loop

	.Loop:
		;; todo macro
		call draw_dummy_window
		call check_for_input
		jmp .Loop
	ret

;; Write title bar at top of the gui
writeTitleBar:
	mov ah, 0x02
	mov bh, 0x00
	mov dh, 0x00
	mov dl, 0x00
	int 0x10
	mov ax, 0x0700
	mov bh, 0x9f
	mov cx, 0x00 	;; row
	mov dx, 0x4f	;; column
	int 0x10

	mov bx, pad
	call printf

	mov bx, instructions
	call printf
	ret

clear:
	mov ah, 07h
	mov al, 00h
	mov ch, 0x00
	mov cl, 0x00

	mov dh, 25
	mov dl, 80
	int 0x10

	;; Disable cursor, actually
	mov ah, 0x01
	mov ch, 0x3f
	int 0x10
	ret

;;; Window Structure
;; Contains information about a singular window
struc win
	.x: resw 1				;; X position
	.y: resw 1				;; Y position
	.w: resw 1				;; Width of window,  must be less than 80
	.h: resw 1				;; Height of window, must be less than 24
	.focused: resb 1	;; 0x00 -> Unfocused
										;; 0xFF -> Focused
endstruc

;; Draw dummy window
draw_dummy_window:
	;; move cursor to initial X/Y position
	mov ah, 0x02
	mov bh, 0x00
	mov dh, 4 		;; Y
	mov dl, 30		;; X
	int 0x10

	;; draw title
	mov ah, 0x09
	mov al, ' '
	mov bh, 0x00
	mov bl, 0x2f
	mov cx, 17
	int 0x10


	;; TODO: check if variable
	;; is 0x00 or 0xFF
	mov bx, f_
	call printf


	mov bx, dummy_win_title
	call printf

	;; move cursor back
	mov ah, 0x02
	mov bh, 0x00
	mov dh, 4
	int 0x10

	mov si, 0

	.Loop:
		call nline_fix

		;; draw the rest
		mov ah, 0x09
		mov al, ' '
		mov bh, 0x00
		mov bl, 0x7f
		mov cx, 17
		int 0x10

		;; Loop!
		inc si
		cmp si, 5
		je .Rest_
		jne .Loop

	;; Exit
	.Rest_:
		ret

check_for_input:
	xor ax, ax
	mov ah, 0x00
	int 16h

	cmp al, 'q'
	je .Quit
	jne .Other

	.Quit:
		call commands.Clear
		;; set cursor back to original
		mov ah, 0x01
		mov ch, 0x00
		mov cl, 15
		int 0x10

		jmp shell
		ret
	.Other:
		ret

nline_fix:
	mov ah, 0x0e
	mov al, `\n`
	int 0x10
	ret

;; Instructions (Data)
instructions: db `Press Tab to switch windows | WASD to move window | Q to quit\r\n`, 0
pad: db `         `, 0

;;; Reserve space for dummy window
;;; TODO: actually use the struct defined
dummy_win_focused: db 0x00					;; Default: Focused
dummy_win_title: db "Dummy Win.", 0

;; Focused or not
f_: db "[F] ", 0
uf: db "[UnF.] ", 0

;;
data_move_0: db "Up", 0
data_move_1: db "Left", 0
data_move_2: db "Right", 0
data_move_3: db "Down", 0