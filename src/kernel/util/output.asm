;; Output to screen

;; Print out a string
;; BX => string to print

;; NOTE: broken!!
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


print:
      mov ah, 0Eh         ;Set function

    .run:
      lodsb               ;Get the char
      cmp al, 0           ;0 has a HEX code of 0x48 so its not 0x00
      je .done            ;Jump to done if ending code is found
      int 10h             ;Else print
      jmp .run            ; and jump back to .run

    .done:
      ret
;; print hex
printh_:
    ;; Save state
    push ax
    push bx
    push cx

    ;; Enable print mode
    mov ah, 0Eh

    ;; Print prefix
    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    ;; Initialize cx as counter
    ;; 4 nibbles in 16-bits
    mov cx, 4

    ;; Begin loop
    printh_loop:
        ;; If cx==0 goto end
        cmp cx, 0
        je printh_end

        ;; Save bx again
        push bx

        ;; Shift so upper four bits are lower 4 bits
        shr bx, 12

        ;; Check to see if ge 10
        cmp bx, 10
        jge printh_alpha

            ;; Byte in bx now < 10
            ;; Set the zero char in al, add bl
            mov al, '0'
            add al, bl

            ;; Jump to end of loop
            jmp printh_loop_end

        printh_alpha:
            
            ;; Bit is now greater than or equal to 10
            ;; Subtract 10 from bl to get add amount
            sub bl, 10
            
            ;; Move 'A' to al and add bl
            mov al, 'A'
            add al, bl


        printh_loop_end:

        ;; Print character
        int 0x10

        ;; Restore bx
        ;; Shift to next 4 bits
        pop bx
        shl bx, 4

        ;; Decrement cx counter
        dec cx

        ;; Jump to beginning of loop
        jmp printh_loop

printh_end:
    ;; Restore state
    pop cx
    pop bx
    pop ax

    ;; Jump to calling point
    ret