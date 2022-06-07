;; Write to sector on hard disk
;; --------------------------------
;; Yes, I'm aware that this uses INT 0x13
;; I know it's not a good idea but I cannot
;; be bothered to implement FAT12 only to
;; give up and have to write my own file system
;; from scratch


;; Write Sectors: Write to a disk sector
;; Arguments:
;; bh => Number of sectors to write
;; bl => Sector number
;; bx => Buffer to write to disk
Write_Sectors:
  mov ah, 03
  mov al, bh
  mov ch, 0
  mov cl, bl
  mov dh, 0
  mov dl, 0x80
  mov bx, cx
  int 0x13
  ret

errp:
  mov bx, errp_given
  call printf

  movzx bx, ah
  call printh_

  call nline
  ret


;; No error
_errp:
  mov bx, YesWrite
  call printf

  ;; CL
  mov bx, YesWriteC
  call printf

  movzx bx, cl
  call printh_

  call nline

  ;; AL
  mov bx, YesWriteA
  call printf

  movzx bx, al
  call printh_

  call nline

  ;; ES
  mov bx, YesWriteE
  call printf

  mov bx, es
  call printh_

  call nline
  ;; BX
  mov bx, YesWriteB
  call printf

  mov bx, dx
  call printh_

  call nline

  ;; go back
  jmp kstart

;; DATA
errp_given: db `Writing to the sector failed.. You dumb?\r\nAH: `, 0
errp_no:    db `No error returned, hopefully written to disk!\r\n`, 0

YesWrite: db `I wrote sectors! Listing some info!\r\n`, 0
YesWriteC: db `CL: `, 0
YesWriteA: db `AL: `, 0
YesWriteE: db `ES: `, 0
YesWriteB: db `BX: `, 0
