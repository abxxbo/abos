NyanCat:
	push cs
	pop ds
	push cs
	pop es
	cld

	mov cx, 25
	mov di, starlist
	.l0: 
		rdtsc
		xchg si, ax		;; maybe?
		xor si, ax
		rol si, 7
		stosw
		loop .l0
		; 320x200x256
		mov ax, 0x13
		int 010h

		push 0xa000
		pop es

		push 4
		push es

		mov bp, 320*2
		
		.nyan:
			;; paint background
			xor di, di
			mov ax, 126
			xor cx, cx
			dec cx
			rep stosb

			mov di, 64*320
			mov cl, 5

		.rainbow:
			push di
			add di, bp
			neg bp			;; potential change

		;; gr strip 1
		push cx
		mov cl, 5
		mov al, 40
		.l1:
			mov bx, 24
			mov dx, 12
			call rect
			add al, 4
			loop .l1		;; potential change (loop .l0)
			pop cx
			pop di
			add di, 24
			loop .rainbow	;; potential change
		
		pop di
		add di, 24
		loop .rainbow

		add di, bp
		push di

		mov cl, 25
		mov bx, starlist

		.starloop:
			sub word [bx],4
			mov di, word [bx]
			cmp  byte [bx],(028h)
			ja .l2
			mov si, star1
			jp .l3
			mov si, star2

			.l2:
				push bx
				call .xsquares
				pop bx
			.l3:
				inc bx
				inc bx
				loop .starloop

	;
	; tail
	;
		mov cl, 3
		mov di, 92*320+100
		.l4:
			mov bx, 12
			xor ax, ax
			call square
			add di, 320*-8+4
			mov al, 25
			mov dl, 4
			call .rect
			add di, 320*-8+-16
			sup di, bp
			sub di, bp
			loop .l4
		pop di
		mov si, data
		call .xslantedrect
		call .double_xslantedrect

		pop ax
		pop dx
		neg ax
		jns .hop	;; ??
		neg bp
		neg dx
		.hop:
			neg bp
			push dx
			push ax
			sub di, dx

;; i'm so tired ...

;
; catface
;
WARNING, Line 126: no syntax match: "add $(320*24+44), %di"
MISMATCH: "add $(320*24+44), %di"

call double_xslantedrect

WARNING, Line 130: no syntax match: "mov $5, %cl"
MISMATCH: "mov $5, %cl"
.l0: 
call xsquares
loop 0b

;
; feet
;

WARNING, Line 139: no syntax match: "add $(320*8-72), %di"
MISMATCH: "add $(320*8-72), %di"
call foot
WARNING, Line 141: no syntax match: "add $20, %di"
MISMATCH: "add $20, %di"
call foot
WARNING, Line 143: no syntax match: "add $36, %di"
MISMATCH: "add $36, %di"
call foot
WARNING, Line 145: no syntax match: "add $24, %di"
MISMATCH: "add $24, %di"
call foot


; ax not signed? probably
; cx=0
WARNING, Line 151: no syntax match: "cwd"
MISMATCH: "cwd"
WARNING, Line 152: no syntax match: "inc %cx"
MISMATCH: "inc %cx"
WARNING, Line 153: no syntax match: "mov $0x86, %ah"
MISMATCH: "mov $0x86, %ah"
int 015h

;mov $(0x3da), %dx
;wait_for_retrace_end:
;in %dx, %ax
;test $8, %al
;jz wait_for_retrace_end
;wait_for_retrace_start:
;in %dx, %ax
;test $8, %al
;jnz wait_for_retrace_start
jmp nyan

xsquares: 
lodsb
WARNING, Line 169: no syntax match: "xchg %ax, %bx"
MISMATCH: "xchg %ax, %bx"
lodsb
.l0: 
WARNING, Line 172: no syntax match: "xchg %ax, %dx"
MISMATCH: "xchg %ax, %dx"
lodsb
WARNING, Line 174: no syntax match: "cmp $4, %al"
MISMATCH: "cmp $4, %al"
je some_ret
call load_coord_jump
WARNING, Line 177: no syntax match: "xchg %ax, %dx"
MISMATCH: "xchg %ax, %dx"
call square
jmp 0b

square: 
WARNING, Line 182: no syntax match: "mov %bx, %dx"
MISMATCH: "mov %bx, %dx"
rect: 
WARNING, Line 184: no syntax match: "push %cx"
MISMATCH: "push %cx"
.l0: 
WARNING, Line 186: no syntax match: "push %di"
MISMATCH: "push %di"
WARNING, Line 187: no syntax match: "mov %bx, %cx"
MISMATCH: "mov %bx, %cx"
rep stosb
WARNING, Line 189: no syntax match: "pop %di"
MISMATCH: "pop %di"
add  di,320
WARNING, Line 191: no syntax match: "dec %dx"
MISMATCH: "dec %dx"
jne 0b
WARNING, Line 193: no syntax match: "pop %cx"
MISMATCH: "pop %cx"
some_ret: 
ret

double_xslantedrect: 
call xslantedrect

xslantedrect: 
lodsb
call load_coord_jump
WARNING, Line 203: no syntax match: "push %di"
MISMATCH: "push %di"
WARNING, Line 204: no syntax match: "xor %ax, %ax"
MISMATCH: "xor %ax, %ax"
lodsb
WARNING, Line 206: no syntax match: "xchg %ax, %cx"
MISMATCH: "xchg %ax, %cx"
lodsb
WARNING, Line 208: no syntax match: "xchg %ax, %bx"
MISMATCH: "xchg %ax, %bx"
lodsb
WARNING, Line 210: no syntax match: "xchg %ax, %dx"
MISMATCH: "xchg %ax, %dx"
lodsb
.l0: 
pusha
call rect
popa
WARNING, Line 216: no syntax match: "sub $8, %dl"
MISMATCH: "sub $8, %dl"
WARNING, Line 217: no syntax match: "add $8, %bl"
MISMATCH: "add $8, %bl"
WARNING, Line 218: no syntax match: "add $(320*4-4), %di"
MISMATCH: "add $(320*4-4), %di"
loop 0b
WARNING, Line 220: no syntax match: "pop %di"
MISMATCH: "pop %di"
ret

load_coord_jump:  ; byte -> ( x:[-10..21], y:[-4..3] ) -> x*4 + y*1280
	xor ah, ah
WARNING, Line 225: no syntax match: "shl $2, %ax"
MISMATCH: "shl $2, %ax"
WARNING, Line 226: no syntax match: "add %ax, %di"
MISMATCH: "add %ax, %di"
WARNING, Line 227: no syntax match: "shr $7, %ax"
MISMATCH: "shr $7, %ax"
WARNING, Line 228: no syntax match: "imul $1152, %ax, %ax"
MISMATCH: "imul $1152, %ax, %ax"
WARNING, Line 229: no syntax match: "add $-5160, %ax"
MISMATCH: "add $-5160, %ax"
WARNING, Line 230: no syntax match: "add %ax, %di"
MISMATCH: "add %ax, %di"
ret

foot: 
pusha
call double_xslantedrect
popa
ret

data: 
db     106
db    3,72,72,0

db     170
db    2,72,64,89

db     172
db    3,56,56,60

db     138
db    4,40,40,0

db     170
db    3,40,32,25

db    16,25
db     40,20,4

db    8,65
db     225,85,4

db    8,0
db     1,81,4

db    4,15
db     67,113,4

db    4,0
db     32,74,74,74,75,107,139,138,113,74,75,107,139,138,138,138,197,166,138,107,107,107,107,107,107,74,103,4

feet: 
db     138
db    2,8,12,0

db     170
db    1,8,4,25

star1: 
db    4,15
db    138,10,138,167,107,110,107,167,138         ; 4
star2: 
db    4,15
db    42,140,171,169,136,72,41,43,4

starlist: 
