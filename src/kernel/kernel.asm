;; Test to prove in "kernel space"

;; hang infinently, we don't have much to do
jmp $

;;; ---- functions ----

input:
  xor ax, ax
  mov ah, 00h
  int 16h

  mov ch, ah
  mov cl, al

  mov ah, 0x0e
  mov al, cl
  int 0x10
  jmp input

;; includes
%include "util/output.asm"

times 2048-($-$$) db 0