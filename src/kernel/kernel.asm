[org 0x7e00]	;; Set all information to be pointed here.

call clear_scr
call shell

jmp $

%include "io/input.asm"
%include "io/output.asm"
%include "io/shell.asm"


;; padding for size of kernel
;; max size allowed by bootloader is 6,144 bytes.

;; pad the rest with 0s
times 6144-($-$$) db 0