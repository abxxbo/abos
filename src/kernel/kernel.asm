;; init
call time

;; Start up our shell
call shell

;; hang infinently, we don't have much to do
jmp $

;; includes
%include "util/output.asm"
%include "util/input.asm"
%include "util/date.asm"

times 2048-($-$$) db 0