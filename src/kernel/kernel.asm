;; Test to prove in "kernel space"
mov ah, 0x0e
mov al, "h"
int 0x10


;; hang infinently, we don't have much to do
jmp $

times 2048-($-$$) db 0