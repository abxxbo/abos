;; Sound blaster 16 support.
;; !! WARNING !!
;; QEMU is fucky and if using any version past
;; (or version is) 4.0, QEMU will freeze and flickering
;; in audio

;; To get around this, use -nographic or -curses
;; (or just use QEMU v2.11)



;;; Probably should put this in its own file

; Out byte
%macro OUTB 2
  mov dx, %1
  mov al, %2
  out dx, al
%endmacro

; In byte
%macro INB 1
  mov dx, %1
  in al, dx
%endmacro

;; Init from functions below
;; (save space, you just need to do 'call InitSB16')
InitSB16:
  call Reset_SB
  call SpkOn
  call DMAC1

  ;; print :) message
  mov bx, SUCCESS_INITSB16
  call printf

  ret

;; Reset SB
Reset_SB:
  OUTB 0x226, 1
  mov ah, 0x86
  mov cx, 0x0000
  mov dx, 0xFFFF
  int 0x15
  OUTB 0x226, 0
  ret

SpkOn:
  OUTB 0x22C, 0xD1
  ret

;; ISA DMA to transfer
DMAC1:
  OUTB 0x0A, 5    ;; disable channel 1
  OUTB 0x0C, 1    ;; flip flop
  OUTB 0x0B, 0x49 ;; transfer mode
  OUTB 0x83, 0x01
  OUTB 0x02, 0x04
  OUTB 0x02, 0x0F
  OUTB 0x03, 0xFF
  OUTB 0x03, 0x0F
  OUTB 0x0A, 1    ;; enable ch1
  ret

;; Macro for programming the SB-16 to play a specific frequency
%macro PlayFreq 1
  OUTB 0x22C, 0x40
  OUTB 0x22C, %1
  OUTB 0x22C, 0xC0
  OUTB 0x22C, 0x00
  OUTB 0x22C, 0xFE
  OUTB 0x22C, 0x0F
%endmacro

;; Data
SUCCESS_INITSB16: db `Enabled SB16 Driver.\r\n`, 0