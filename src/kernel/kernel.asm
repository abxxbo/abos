[org 0x7e00]	;; Set all information to be pointed here.

;; Initial setup
mov ax, 0x3
int 0x10			;; 80 x 25

;; set colorscheme
mov ax, 600h
mov bh, 0x9f
xor cx, cx
mov dx, 0x304f
int 0x10

jmp $

;; padding for size of kernel
;; max size allowed by bootloader is 6,144 bytes.
;; for now we will use 2048 bytes.

;; pad the rest with 0s
times 2048-($-$$) db 0