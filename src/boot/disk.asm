;; read 12 sectors into memory
;; our kernel is located on sector 2
;; so we have to primarily read that one.
K_LOC equ 0x7e00

disk_read:
	mov ah, 0x02
	mov al, 12			;; number of sectors to read
	mov ch, 0x00		;; low 8 bits of cylinder number
	mov cl, 0x02		;; sector number (1->63)
	mov dh, 0x00		;; head 0
	mov dl, 0				;; drive number
	mov bx, K_LOC		;; 0x7e00 is kernel location

	int 0x13
	
	;; If an error occurs, hang
	jc disk_error
	ret	;; No error, return

disk_error:
	jmp $