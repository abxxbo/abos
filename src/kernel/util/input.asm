;; a scuffed/temporary shell
;; it should be noted that all commands
;; must be 4 letters long.
shell:
  ;; as all shells do, let's add a PS1
  mov ah, 0x0e
  mov al, '$'
  int 0x10
  ;; space, just to make it better
  mov ah, 0x0e
  mov al, ' '
  int 0x10
  ;; input
  xor cl, cl
  .Loop:

    ;; --- input ---  
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

    ;; Redo the PS1 -- aka the '$ ' at the beginning
    ;; of each line
    jmp .RedoPS1

  .RedoPS1:
    mov ah, 0x0e
    mov al, '$'
    int 0x10

    mov ah, 0x0e
    mov al, ' '
    int 0x10

    ;; go back and loop
    jmp .Loop
