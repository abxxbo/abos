;; set up stack
[org 0x7c00]
xor ax, ax
mov ds, ax
mov es, ax

mov sp, 0x7c00
mov bp, sp

mov al, 0x03
mov ah, 0
int 0x10

call detect_low
;; Makes disk reading
;; fail:
; call detect_upper


mov [BDISK], dl
call disk_read
jmp K_LOC     ;; assume to be 0x7e00

jmp $

%include "disk.asm"
%include "output.asm"
%include "d_mem.asm"

;; padding
times 510 - ($-$$) db 0
dw 0xAA55