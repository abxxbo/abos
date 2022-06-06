;; Test to prove in "kernel space"

call input

;; hang infinently, we don't have much to do
jmp $

;;; ---- functions ----

input:
  ;; input
  xor cl, cl
  .Loop:
    xor ax, ax
    mov ah, 00h
    int 16h

    mov ch, ah
    mov cl, al

    ;; Now we want to print it out
    jmp .LPrint
  ;; print out character stored at cl
  .LPrint:
    ;; Enter key
    cmp cl, 13  ;; enter key
    je .Enter
    
    ;; actually print
    mov ah, 0x0e
    mov al, cl
    int 0x10
    jmp .Loop
  
  ;; special keys

  ;; Enter key 
  .Enter:
    mov ah, 0x0e
    mov al, `\n`
    int 0x10
    
    mov ah, 0x0e
    mov al, `\r`
    int 0x10

    ;; go back and loop
    jmp .Loop

;; includes
%include "util/output.asm"

times 2048-($-$$) db 0