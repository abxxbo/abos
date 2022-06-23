[org 0x7e00]	;; Set all information to be pointed here.

mov ah, 0x0e
mov al, 't'
int 0x10

jmp $

;; padding for size of kernel
;; max size allowed by bootloader is 6,144 bytes.
;; for now we will use 2048 bytes.

;; pad the rest with 0s
times 2048-($-$$) db 0