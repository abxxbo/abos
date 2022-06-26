;; Get input from user.
;; Uses 0x16.

get_char:
	xor ax, ax
	mov ah, 0x00
	int 0x16
	ret


;; Special characters
;; Input:
;;		al -> ASCII character
special_characters:
	mov cl, al
	;; Enter
	cmp cl, 13
	je .Enter
	ret

	.Enter:
		mov ah, 0x0e
		mov al, `\n`
		int 0x10
		ret