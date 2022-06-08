[org 0x8000]
;; init
call time

;; Change cursor again to biggest possible.
;; When loading into the next sector for
;; some reason it doesnt want to do it by itself
mov ah, 0x01
mov ch, 0x00
mov cl, 15
int 0x10

call shell

;; hang infinently, we don't have much to do
jmp $

;; Constants
KVER: db 'v0.0.1-prerelease', 0 ;; I feel horrible hard coding it

;; includes
%include "util/output.asm"
%include "util/input.asm"
%include "util/date.asm"

times 2560-($-$$) db 0