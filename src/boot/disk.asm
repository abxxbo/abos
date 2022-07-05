K_LOC equ 0x7e00

disk_read:
  mov ah, 0x02
  mov bx, K_LOC
  mov al, 4
  mov dl, [BDISK]
  mov ch, 0x00
  mov dh, 0x00
	mov cl, 0x02

  int 0x13

  jc failed_read
  ret

BDISK: db 0

failed_read:
  mov bx, failed_read_
  call printf

  mov ah, 0x01
  mov dl, [BDISK]
  int 0x13

  cmp ah, 0x03
  je .WriteProtected
  cmp ah, 0x04
  je .NotFound
  jmp $
  .WriteProtected:
    mov bx, fail_0
    call printf
    jmp $
  .NotFound:
    mov bx, fail_1
    call printf
    jmp $

failed_read_: db `Can't read disk\r\n`, 0
fail_0: db `Yo, it's write protected!`, 0
fail_1: db `Yo, I can't find sector`, 0