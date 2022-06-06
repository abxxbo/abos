;; init
call time

mov ah, 0x0e
mov al, `\r`
int 0x10
mov al, `\n`
int 0x10

;; Start up our shell
call shell

;; hang infinently, we don't have much to do
jmp $

;; includes
%include "util/output.asm"
%include "util/input.asm"

times 2048-($-$$) db 0