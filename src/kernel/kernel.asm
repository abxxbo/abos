[org 0x8000]
;; init
call time


mov dl, 0
mov cl, 3
mov al, 1
call Read_Sectors
mov dx, bx
jnc FailedRead
jc SuccessRead

;; Start up our shell
kstart:
  call nline
  call shell

;; hang infinently, we don't have much to do
jmp $

;; includes
%include "util/output.asm"
%include "util/input.asm"
%include "util/date.asm"

;; file system
%include "fs/fs-read.asm"
%include "fs/fs-write.asm"

times 2048-($-$$) db 0