[org 0x7e00]	;; Set all information to be pointed here.

;; set colorscheme
mov al, 0x03
mov ah, 0
int 0x10

mov ah, 0x0b
mov bh, 0x00
mov bl, 0x9
int 0x10

Loop:
	call get_char
	call special_characters
	mov ah, 0x0e
	mov al, cl
	int 0x10
	jmp Loop

jmp $

%include "io/input.asm"

;; padding for size of kernel
;; max size allowed by bootloader is 6,144 bytes.
;; for now we will use 2048 bytes.

;; pad the rest with 0s
times 2048-($-$$) db 0