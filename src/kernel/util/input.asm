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
  xor dx, dx
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

    ;; stupid thing, this is going to take forever to write

    cmp cl, 'a'
    je letters.A

    cmp cl, 'b'
    je letters.B

    cmp cl, 'c'
    je letters.C

    cmp cl, 'd'
    je letters.D

    cmp cl, 'e'
    je letters.E

    cmp cl, 'f'
    je letters.F

    cmp cl, 'g'
    je letters.G

    cmp cl, 'h'
    je letters.H

    cmp cl, 'i'
    je letters.I

    cmp cl, 'j'
    je letters.J

    cmp cl, 'k'
    je letters.K

    cmp cl, 'l'
    je letters.L

    cmp cl, 'm'
    je letters.M

    cmp cl, 'n'
    je letters.N

    cmp cl, 'o'
    je letters.O

    cmp cl, 'p'
    je letters.P

    cmp cl, 'q'
    je letters.Q

    cmp cl, 'r'
    je letters.R

    cmp cl, 's'
    je letters.S

    cmp cl, 't'
    je letters.T

    cmp cl, 'u'
    je letters.U

    cmp cl, 'v'
    je letters.V

    cmp cl, 'w'
    je letters.W

    cmp cl, 'x'
    je letters.X

    cmp cl, 'y'
    je letters.Y

    cmp cl, 'z'
    je letters.Z

    ;; jump back to loop
    jmp .Loop
  
  ;; special keys

  ;; Enter key 
  .Enter:

    ;; compare
    cmp dx, 0x0029
    je commands.Help

    cmp dx, 0x001E
    je commands.Date

    cmp dx, 0x0040
    je commands.Test

    mov ah, 0x0e
    mov al, `\n`
    int 0x10
    
    mov ah, 0x0e
    mov al, `\r`
    int 0x10

    mov bx, dx
    call printh_

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
    xor dx, dx
    jmp .Loop


;; letters
letters:
  .A:
    add dx, 1
    jmp shell.Loop
  .B:
    add dx, 2
    jmp shell.Loop
  .C:
    add dx, 3
    jmp shell.Loop
  .D:
    add dx, 4
    jmp shell.Loop
  .E:
    add dx, 5
    jmp shell.Loop
  .F:
    add dx, 6
    jmp shell.Loop
  .G:
    add dx, 7
    jmp shell.Loop
  .H:
    add dx, 8
    jmp shell.Loop
  .I:
    add dx, 9
    jmp shell.Loop
  .J:
    add dx, 10
    jmp shell.Loop
  .K:
    add dx, 11
    jmp shell.Loop
  .L:
    add dx, 12
    jmp shell.Loop
  .M:
    add dx, 13
    jmp shell.Loop
  .N:
    add dx, 14
    jmp shell.Loop
  .O:
    add dx, 15
    jmp shell.Loop
  .P:
    add dx, 16
    jmp shell.Loop
  .Q:
    add dx, 17
    jmp shell.Loop
  .R:
    add dx, 18
    jmp shell.Loop
  .S:
    add dx, 19
    jmp shell.Loop
  .T:
    add dx, 20
    jmp shell.Loop
  .U:
    add dx, 21
    jmp shell.Loop
  .V:
    add dx, 22
    jmp shell.Loop
  .W:
    add dx, 23
    jmp shell.Loop
  .X:
    add dx, 24
    jmp shell.Loop
  .Y:
    add dx, 25
    jmp shell.Loop
  .Z:
    add dx, 26
    jmp shell.Loop



commands:
  .Help:
    call nline
    
    ;; jump back
    call nline
    jmp shell.RedoPS1
  .Date:
    call nline
    call time

    ;; jmp back
    jmp shell.RedoPS1

nline:
  mov ah, 0x0e
  mov al, `\n`
  int 0x10

  mov ah, 0x0e
  mov al, `\r`
  int 0x10
  ret

;; data
