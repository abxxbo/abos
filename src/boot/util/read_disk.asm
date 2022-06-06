;; where are next sectors are gonna be
PROG_LOC equ 0x8000

disk_reads:
  mov ah, 0x02
  mov bx, PROG_LOC
  mov al, 4         ;; 4 sectors to read (qemu goes crazy if too many are given)
  mov dl, [BDK]
  mov ch, 0x00      ;; drive head
  mov dh, 0x00      ;; drive cylinders
  mov cl, 0x02

  int 0x13

  ;; if disk fails, hang
  jc failed_read
  ret

BDK: db 0

failed_read:
  ;; alternatively, reboot and try again
  jmp $