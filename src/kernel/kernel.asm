[org 0x7e00]	;; Set all information to be pointed here.

%include "io/output.asm"
printc 0x61
call shell

jmp $

%include "io/shell.asm"
