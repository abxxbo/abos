[org 0x7e00]	;; Set all information to be pointed here.

call clear_scr
call shell

jmp $

%include "io/input.asm"
%include "io/output.asm"
%include "io/shell.asm"
