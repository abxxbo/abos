;; A primitive GUI of sorts

StartGUI__:
	;; Initialize some things
	call clear
	call writeTitleBar

	;; Event loop
	call draw_dummy_window

	.Loop:
		jmp .Loop
	ret

;; Write title bar at top of the gui
writeTitleBar:
	mov ax, 0x0700
	mov bh, 0x70
	mov cx, 0x00 	;; row
	mov dx, 0x4f	;; column
	int 0x10

	mov bx, instructions
	call printf
	ret

clear:
	mov bx, Cl_nl_
	call printf

	;; move cursor back to 0, 0
	mov ah, 0x02
	mov bh, 0x00
	mov dh, 0x00
	mov dl, 0x00
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
	mov dh, 4
	mov dl, 4
	int 0x10

	;; draw title
	mov ah, 0x09
	mov al, ' '
	mov bh, 0x00
	mov bl, 0x2f
	mov cx, 12
	int 0x10

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
		mov cx, 12
		int 0x10

		;; Loop!
		inc si
		cmp si, 5
		je .Rest_
		jne .Loop

	;; Exit
	.Rest_:
		ret

nline_fix:
	mov ah, 0x0e
	mov al, `\n`
	int 0x10
	ret

;;; Clear
Cl_nl_: db `\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n`, 0
nl_: db `\n`, 0

;; Instructions (Data)
instructions: db `Press Tab to switch windows | Arrow keys to move around\r\n`, 0


;;; Reserve space for dummy window
;;; TODO: actually use the struct defined
dummy_win_focused: db 0xFF						;; Default: Focused
dummy_win_title: db "Dummy Win.", 0