[org 0x7c00]
jmp 0x0000:start_16

start_16:
  xor ax, ax
  cli
  mov ss, ax
  mov sp, 0x7c00
  sti
  mov ds, ax
  mov es, ax


;; Before we jump to our "kernel", we need to do some things

;;; set video mode
mov al, 0x03      ;; resolution
mov ah, 0
int 0x10

;; give a message when in bootloader
mov bx, welcome_boot
call printf

;; change resolution based on what user asks
mov bx, reset_res0
call printf

xor ax, ax
int 16h

mov cl, al
mov ah, 0x0e
mov al, cl
int 0x10

;; compare
cmp al, '0'
je SetVid40
jl Unrecognized

cmp al, 49
je SetVid80
jg Unrecognized

start:
  ;;; change color pallete
  mov ah, 0x0b
  mov bh, 0x00
  mov bl, 0x1
  int 0x10

  ;;; display a welcome message
  mov bx, welcome
  call printf

  mov bx, welcome2
  call printf


  ;; Go to kernel!
  mov [BDK], dl
  call disk_reads
  jmp PROG_LOC

jmp $

;; data
welcome: db `Booted into abos!\r\nType 'help' for a guide on commands.\r\n\r\n`, 0
welcome2: db `I booted on `, 0

welcome_boot: db `Welcome to abos. Please select a resolution.\r\n`, 0

reset_res0: db `\r\n0: 40x25\r\n1: 80x25\r\nChoice: `, 0
reset_res1: db `\r\nUnrecognized resolution. Press any key to reboot and try again.`, 0

;; includes
%include "util/read_disk.asm"
%include "util/output.asm"


;; functions
SetVid40:
  mov al, 0x00
  mov ah, 0
  int 0x10
  jmp start

SetVid80:
  mov al, 0x03
  mov ah, 0
  int 0x10
  jmp start

Unrecognized:
  mov bx, reset_res1
  call printf

  ;; restart so they have an option
  ;; to chose
  xor ax, ax
  int 16h
  int 19h

;; padding
times 510 - ($-$$) db 0
dw 0xAA55