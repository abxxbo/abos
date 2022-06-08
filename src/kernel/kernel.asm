[org 0x8000]
;; init
call time
call shell

;; hang infinently, we don't have much to do
jmp $

;; includes
%include "util/output.asm"
%include "util/input.asm"
%include "util/date.asm"

times 2560-($-$$) db 0