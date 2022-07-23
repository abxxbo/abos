[org 0x7e00]	;; Set all information to be pointed here.

mov bx, welcome0
call printf

call shell
jmp $

welcome0: db `Welcome to AbOS -- An experimental 16-bit OS\r\n# `, 0

%include "io/output.asm"
%include "io/shell.asm"
