[org 0x7e00]	;; Set all information to be pointed here.

mov ax, 0xb800
mov es, ax

call shell
jmp $
foo:  db "syscall->0x0f", 0

%include "io/output.asm"
%include "io/shell.asm"
