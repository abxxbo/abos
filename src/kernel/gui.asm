;; A primitive GUI of sorts

StartGUI__:
	;; Initialize some things
	call clear
	call writeTitleBar

	;; Event loop
	.Loop:
		jmp .Loop
	ret

;; Write title bar at top of the gui
writeTitleBar:
	mov ax, 0x0700
	mov bh, 0x70
	mov cx, 0x0000
	mov dx, 0x004f
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


;;; Clear
Cl_nl_: db `\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n`, 0


;; Instructions (Data)
instructions: db `Press Tab to switch windows | Arrow keys to move around\r\n`, 0