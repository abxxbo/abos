;; this assumes that all variables are stored as
;; 'win_x', 'win_y', etc.
;; NOTE/FIXME: it may be better to actually store it in a struct
;; so probably initialize a struct as the window and do something
;; like window.x, window.y
window_move:
	xor ax, ax
	mov ah, 0x00
	int 0x16

	cmp al, 'a'
	je .MoveLeft

	cmp al, 'd'
	je .MoveRight

	.MoveRight:
		xor dx, dx
		mov dx, win_x
		add dx, 1
		mov [win_x], dx
		ret
	.MoveLeft:
		xor dx, dx
		mov dx, win_x
		sub dx, 1
		mov [win_x], dx
		ret
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