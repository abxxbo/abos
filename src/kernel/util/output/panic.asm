Panic:
  call Clear
  ;; change color to red
  mov ah, 0x0b
  mov bh, 0x00
  mov bl, 0x4
  int 0x10

  ;; print first paragraph
  mov bx, panic0
  call printf

  mov bx, panic1
  call printf

  mov bx, panic2
  call printf

  ;; registers
  mov bx, reg1
  call printf

  mov bx, ax
  call printh_

  mov bx, sep
  call printf

  ;; BX
  mov dx, bx
  mov bx, reg2
  call printf

  mov bx, dx
  call printh_

  mov bx, sep
  call printf

  ;; CX
  mov bx, reg3
  call printf

  mov bx, cx
  call printh_

  mov bx, sep
  call printf

  call nline

  ;; AH
  mov bx, reg5
  call printf

  movzx bx, ah
  call printh_

  mov bx, sep
  call printf

  ;; AL
  mov bx, reg6
  call printf

  movzx bx, al
  call printh_
  call nline

  mov ah, 0x01
  mov ch, 0x3f
  int 0x10
  jmp $
  ret

Clear:
  mov ah, 0x02
  mov bh, 0x00
  mov dh, 0x00
  mov dl, 0x00
  int 0x10
  ret

;; data
panic0: db `              !! PANIC !!                    \r\n`, 0
panic1: db `Something went wrong and AbOS cannot recover.\r\n`, 0
panic2: db `Here are some register values to try and help\r\nyou:\r\n\r\n`, 0

;;; reg
reg1: db `AX: `, 0
reg2: db `BX: `, 0
reg3: db `CX: `, 0
reg5: db `AH: `, 0
reg6: db `AL: `, 0
sep: db ` | `,   0