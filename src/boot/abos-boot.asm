[org 0x7c00]
mov bp, 0x7c00
mov sp, bp

;; Before we jump to our "kernel", we need to do some things

;;; set video mode
mov al, 0x03
mov ah, 0
int 0x10

;;; display a welcome message
mov bx, welcome
call printf

;; Go to kernel!
mov [BDK], dl
call disk_reads
jmp PROG_LOC

jmp $

;; data
welcome: db `Welcome to abos!\r\n`, 0

;; includes
%include "util/read_disk.asm"
%include "util/output.asm"


;; padding
times 510 - ($-$$) db 0
dw 0xAA55