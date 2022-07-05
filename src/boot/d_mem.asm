;; Detecting memory

;; Low continous memory (starting from 0x00)
detect_low:
	int 0x12

	mov bx, low_mm_0
	call printf

	mov bx, ax
	call printh
	ret

;; Detecting upper memory -- default to using
;; CX/DX pair (INT 0x15/AX = 0xE801)
detect_upper:
	;; reset CX/DX, if CX/DX is still 0 after
	;; interrupt than error out
	xor cx, cx
	xor dx, dx

	;; request
	mov ax, 0xE801
	int 0x15

	mov bx, up_mm_1
	call printf

	mov bx, cx
	call printh
	
	printc `\r`
	printc `\n`
	
	ret

;; data
low_mm_0: db 'Low (continous) memory starting from 0x00: ', 0
low_mm_2: db `Cannot get low memory using INT=0x12\r\n`, 0

up_mm_1: db `\r\nUpper memory (continous, 1M->16M): `, 0
up_mm_2: db `Can't get upper memory using INT=0x15\r\nPossible causes:\r\nUnsupported or Invalid.\r\n`, 0