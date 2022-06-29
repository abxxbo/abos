;; panic screen

;; Possible statuses for panic:
;; 0x00 -> User-initiated | 0x01 -> FS Failure
;; Anything else is given as 'Unknown' for the status

%macro kpanic 1
	mov di, %1
	call kpanic__
%endmacro

;; Input:
;;	di -> Status for Panic. See comment on line 3
kpanic__:
	mov bx, kpanic0
	call printf

	;; normal strings
	mov bx, kpanic1
	call printf

	cmp di, 0x00
	je .UInit

	cmp di, 0x01
	je .FFail
	
	mov bx, uknow
	call printf

	cli
	hlt

	.UInit:
		mov bx, uinit
		call printf
		cli
		hlt
	.FFail:
		mov bx, ffail
		call printf
		cli
		hlt
	jmp $

;; data
kpanic0: db `KPanic call initiated!\r\n\r\n`, 0
kpanic1: db `Status from call: `, 0

;;; statuses
uinit: db `User Initiated KPanic\r\n`, 0
ffail: db `FS Failure (KPanic)\r\n`, 0
uknow: db `Unkown Reason\r\n`, 0