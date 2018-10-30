bits 16

; Let’s just leave this for now and we will try to understand what is
; happening later. The piece of code goes like this:
start:
  mov ax, 0x07C0  ; 0x07c00 is were we are
  add ax, 0x20    ; add 0x20 (when shifted 512)
  mov ss, ax      ; set the stack segment
  mov sp, 0x1000  ; set the stack pointer

  mov ax, 0x07C0  ; set data segment...
  mov ds, ax      ; more about this later

; So far so good
; It’s now time to set up the arguments for the BIOS print procedure.
  mov si, msg       ; pointer to the message in SI
  mov ah, 0x0E      ; print char BIOS procedure

; Now for the printing of the message; we will load one byte
; from whatever SI is pointing to
; and copy it to register AL
; check that it is not equal to zero
; and print it to the screen.
