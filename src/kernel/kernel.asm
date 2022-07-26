[org 0x7e00]	;; Set all information to be pointed here.

mov ah, 0eh
mov al, '#'
int 0x10

mov ah, 0eh
mov al, ' '
int 0x10



call shell
jmp $

%include "stdio.asm"
%include "io/shell.asm"
