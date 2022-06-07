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
;; dh => Sector number
;; bl => Low 8-bits of cylinder number
;; sp => buffer to write to disk
Write_Sectors:
  mov ah, 0x03
  mov al, bh
  mov ch, dh
  mov dh, 0x00  ;; drive 0 head 0
  mov dl, 0
  ;; ES:BX part
  mov bx, sp

  int 0x13

  ;; Any errors?
  jnc _errp
  jc errp
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
  mov bx, errp_no
  call printf
  call nline
  mov ah, 0x01
  mov dl, 0
  int 0x13

  movzx bx, ah
  call printh_

  call nline
  ret

;; DATA
errp_given: db `Writing to the sector failed.. You dumb?\r\nAH: `, 0
errp_no:    db `No error returned, hopefully written to disk!\r\n`, 0