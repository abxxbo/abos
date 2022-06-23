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
  jmp $