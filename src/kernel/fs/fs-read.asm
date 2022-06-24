;; Read a sector to memory into a
;; pre-determined data buffer
;; Input:
;;	cl -> sector number
read_sector:
	mov ah, 0x02
	mov al, 1		;; only read one sector
	mov ch, 0x00
	mov dh, 0x00
	mov dl, 0
	mov bx, read_buf
	int 0x13
	jc Failed

Failed:
	mov bx, failed_to_read
	call printf

;; data
failed_to_read: db `Failed to read next sector.`, 0

;; buffer
read_buf: db 0