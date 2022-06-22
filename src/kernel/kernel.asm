[org 0x8000]
;; intialize GUI
jmp StartGUI__

;; init
call time

;; Initialize SB-16
call InitSB16

;; Change cursor again to biggest possible.
;; When loading into the next sector for
;; some reason it doesnt want to do it by itself
mov ah, 0x01
mov ch, 0x00
mov cl, 15
int 0x10




;; hang infinently, we don't have much to do
jmp $

;; Constants
KVER: db 'v0.0.1-prerelease', 0 ;; I feel horrible hard coding it

;; includes
%include "util/output/output.asm"
%include "util/output/panic.asm"
%include "util/input.asm"
%include "util/date.asm"
%include "gui.asm"

;; drivers
%include "drv/sb16.asm"

times 2560-($-$$) db 0