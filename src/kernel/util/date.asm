time:
    ;; Get date from BIOS
    mov ah, 4h
    int 0x1A
    call xtox
    mov ch, cl
    call xtox
    mov al, '-'
    int 0x10
    mov ch, dh
    call xtox
    mov al, '-'
    int 0x10
    mov ch, dl
    call xtox

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
    call xtox
    mov al, `:`
    int 10h
    mov ch, cl
    call xtox
    mov al, `:`
    int 10h
    mov ch, dh
    call xtox

    ;; Return back
    ret

xtox:
    ;; Output CH as hex
    mov al, ch
    and al, 0xf ;; Clear upper 4 bits -- only want 1st digit
    call xtoasc
    mov ah, al  ;; Store in ah
    mov al, ch
    shr al, 4h  ;; Get 1st digit
    call xtoasc
    mov ch, ah  ;; Store in CH
    
    ;; Output
    mov ah, 0Eh
    int 10h
    mov al, ch
    int 10h
    ret

xtoasc:
    ;; Hex to ASCII
    add al, 30h
    cmp al, 39h
    jle xtaback
    add al, 7h
xtaback:
    ret