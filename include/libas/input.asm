;; Get input from user.
;; Uses 0x16.

get_char:
	xor ax, ax
	mov ah, 0x00
	int 0x16
	ret