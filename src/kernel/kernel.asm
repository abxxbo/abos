[org 0x7e00]	;; Set all information to be pointed here.

;; set colorscheme
mov al, 0x03
mov ah, 0
int 0x10

mov ah, 0x0b
mov bh, 0x00
mov bl, 0x9
int 0x10

mov ah, 0x07
mov al, 0x00
mov bh, 0xf
mov ch, 0
mov cl, 0
mov dh, 80
mov dl, 25
int 0x10


call shell

jmp $


%include "io/input.asm"
%include "io/output.asm"
%include "io/shell.asm"


;; padding for size of kernel
;; max size allowed by bootloader is 6,144 bytes.
;; for now we will use 2048 bytes.

;; pad the rest with 0s
times 2048-($-$$) db 0