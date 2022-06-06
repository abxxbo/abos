;; Output to screen -- note this was copied
;; from kernel!

;; Print out a string
;; BX => string to print

;; NOTE: broken if not on org 0x7c00!!
printf:
  ;; push to stack
  push ax
  push bx
  ;; set the ah register 'ready' for
  ;; teletype (int 0x10) mode
  mov ah, 0Eh
  .Loop:
    ;; if the current byte at [bx] is 0
    ;; (also '\0'), exit loop -- string
    ;; is ended
    cmp [bx], byte 0
    je .LExit
    ;; if the loop did not jump to LExit,
    ;; we can move the current byte at [bx]
    ;; to al, then invoke interrupt 0x10
    mov al, [bx]
    int 0x10      ;; output to teletype
    ;; increase bx (go to next character)
    ;; and jump back to .Loop
    inc bx
    jmp .Loop
  .LExit:
    ;; pop from stack
    pop ax
    pop bx
    ;; return
    ret