[org 0x8000]
;; init
call time
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