;; set up stack
[org 0x7c00]
xor ax, ax
mov ds, ax
mov es, ax

mov sp, 0x7c00
mov bp, sp

mov [BDISK], dl
call disk_read
jmp K_LOC     ;; assume to be 0x7e00

jmp $

%include "disk.asm"

;; padding
times 510 - ($-$$) db 0
dw 0xAA55