[org 0x8000]
;; init
call time

;; write to 3rd sector (troll)
mov bh, 1   ;; number of sectors
mov bl, 3   ;; sector number
mov cx, sector2
call Write_Sectors
jnc _errp
jc errp

kstart:
  ;; Read sectors
  mov dl, 0
  mov cl, 3
  call Read_Sectors
  mov dx, bx
  jnc FailedRead
  jc SuccessRead

  ;; Start up our shell
  .shell:
    mov bx, sector2
    call printh_
    call nline
    call shell

;; hang infinently, we don't have much to do
jmp $

sector2: db "Hi"

;; includes
%include "util/output.asm"
%include "util/input.asm"
%include "util/date.asm"

;; file system
%include "fs/fs-read.asm"
%include "fs/fs-write.asm"

times 2048-($-$$) db 0