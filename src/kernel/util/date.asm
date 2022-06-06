time:
    ;; Get date from BIOS
    mov ah, 4h
    int 0x1A
    call hextohex
    mov ch, cl
    call hextohex
    mov al, '-'
    int 0x10
    mov ch, dh
    call hextohex
    mov al, '-'
    int 0x10
    mov ch, dl
    call hextohex

    ;; add an 'at'
    ;; i know its ugly
    mov ah, 0Eh
    mov al, ' '
    int 0x10
    mov al, 'a'
    int 0x10
    mov al, 't'
    int 0x10
    mov al, ' '
    int 0x10
    

    ;; Get time
    mov ah, 2h
    int 1ah
    call hextohex
    mov al, `:`
    int 10h
    mov ch, cl
    call hextohex
    mov al, `:`
    int 10h
    mov ch, dh
    call hextohex

    ;; Return back
    ret

hextohex:
    ;; Output CH as hex
    mov al, ch
    and al, 0xf ;; Clear upper 4 bits -- only want 1st digit
    call hextoascii
    mov ah, al  ;; Store in ah
    mov al, ch
    shr al, 4h  ;; Get 1st digit
    call hextoascii
    mov ch, ah  ;; Store in CH
    
    ;; Output
    mov ah, 0Eh
    int 10h
    mov al, ch
    int 10h
    ret

hextoascii:
    ;; Hex to ASCII
    add al, 30h
    cmp al, 39h
    jle hextaback
    add al, 7h
hextaback:
    ret