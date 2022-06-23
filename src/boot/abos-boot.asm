[org 0x7c00]
xor ax, ax
mov ds, ax
mov es, ax

mov sp, 0x7c00
mov bp, sp

jmp $

;; padding
times 510 - ($-$$) db 0
dw 0xAA55