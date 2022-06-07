;; probably not the best thing to do
;; but I'll be using INT 0x13 for most
;; of the operations in my """fs"""

;; In this case, I will use INT 0x13/AH=0x02
;; which corresponds to reading sectors of the
;; disk into memory


;; Read_Sectors: reads sectors into memory.
;; Arguments
;; dl       => drive
;; ch       => cylinder[7:0]
;; cl[7:6]  => cylinder[9:8]
;; dh       => head
;; cl[5:0]  => sector (1-63)
;; es:bx    => dest
;; al       => # of sectors
;; Returns
;; cf       => 0: success / 1: failure
Read_Sectors:
  pusha
  mov si, 0x02
  .top:
    mov ah, 0x02    ;; read
    ;; stuff i dont need to pass in
    mov ch, 0x00
    mov dh, 0x00
    int 0x13
    jnc .end        ;; if read success, exit
    dec si          ;; 1 less attempt!
    jc .end         ;; exit if used all attempts
    xor ah, ah      ;; reset disk system
    int 0x13
    jnc .top        ;; loop
  .end:
    popa
    retn

;; Error out for certain registers

;; DX is too small!
Read_Exit_DHS:
  mov bx, DHS
  call printf
  jmp $


;; DX is too big!
Read_Exit_DHG:
  jmp $


;; BH is too small!
Read_Exit_BHS:
  jmp $


;; General Error
FailedRead:
  mov bx, FailedFSRead
  call printf

  movzx bx, ah
  call printh_

  ret


;; Success! we read!
SuccessRead:
  ;; print out values
  mov bx, YesRead
  call printf

  ;; CL
  mov bx, YesReadC
  call printf

  movzx bx, cl
  call printh_

  call nline

  ;; AL
  mov bx, YesReadA
  call printf

  movzx bx, al
  call printh_

  call nline

  ;; ES
  mov bx, YesReadE
  call printf

  mov bx, es
  call printh_

  call nline
  ;; BX
  mov bx, YesReadB
  call printf

  mov bx, dx
  call printh_

  call nline

  ;; go back
  jmp kstart

;;; Data
DRV_N: db 0

DHS: db `The DH register is too small. I cannot do anything with this.\r\n`, 0
DHG: db `The DH register is too big. I cannot do anything with this.\r\n`, 0
BHS: db `The BH register is too small. I cannot do anything with this.\r\n`, 0

FailedFSRead:
  db `I failed to read sectors of the disk! Here's some error things.\r\nAH: `, 0


YesRead: db `I read sectors! Listing some info!\r\n`, 0
YesReadC: db `CL: `, 0
YesReadA: db `AL: `, 0
YesReadE: db `ES: `, 0
YesReadB: db `BX: `, 0


PL equ 0x9000