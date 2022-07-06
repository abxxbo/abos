;; file system using 0x13.
;; i will document this later



;; Read into data buffer
;; Input:
;;	%1 -> number of sectors
;;  %2 -> sector to read specifically
;;	%3 -> data buffer 
%macro read_sector 3
	mov ah, 0x02
	mov dl, 0x00
	mov ch, 0x00
	mov dh, 0x00
	mov al, %1
	mov cl, %2

	;; setup for data buffer
	;; note that this should be
	;; the same as for write_sector's macro
	push bx
	xor bx, bx
	mov es, bx
	pop bx			;; i don't know why i do this really
	mov bx, %3	;; where to *store* the data
	int 0x13

	jc failed_op
%endmacro

;; Write to sector
;; Input:
;;	%1 -> number of sectors
;; 	%2 -> specific sector
;;	%3 -> data buffer
%macro write_sector 3
	mov ah, 0x03
	mov dl, 0x80	;; write to HDD. Note: adjust read and this for 0x00.
	mov ch, 0x00	;; cylinder
	mov dh, 0x00	;; head
	mov al, %1		;; # of sectors
	mov cl, %2		;; specific sector to write
	
	;; setup data buffer
	push bx
	xor bx, bx
	mov es, bx
	pop bx
	mov bx, %3
	int 0x13

	;; if there are any errors we can check in a different label
	jc failed_op
%endmacro


;; Check if sector is free
;; or in use.
;; Input:
;;	%1 -> sector number
;; Output:
;;	di -> free (0x00) or unused (0xFF)
%macro check_if_free 1
	;; First we need to read the sector (we might aswell just use our previously
	;; defined macros for this). Next, we compare with 0.
	read_sector 1, %1, read_buffer_chk
	cmp [read_buffer_chk], byte 0
	je ItFree
	mov di, 0xFF
	ret
%endmacro

ItFree:
	mov di, 0x00
	ret


;;; ------- debuging -------
failed_op:
	mov cx, 0xFFFF
	mov bx, cx
	call printh
	ret

;; buffer for checking if the current sector is empty or not.
;; set to times 512 db 0 because that is equal to 512 bytes
;; (aka 1 full sector)
read_buffer_chk: times 512 db 0
