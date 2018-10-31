bits 16

; Let’s just leave this for now and we will try to understand what is
; happening later. The piece of code goes like this:
start:
  mov ax, 0x07C0    ; 0x07c00 is were we are
  add ax, 0x20      ; add 0x20 (when shifted 512)
  mov ss, ax        ; set the stack segment
  mov sp, 0x1000    ; set the stack pointer

  mov ax, 0x07C0    ; set data segment...
  mov ds, ax        ; more about this later

; So far so good
; It’s now time to set up the arguments for the BIOS print procedure.
  mov si, msg       ; pointer to the message in SI
  mov ah, 0x0E      ; print char BIOS procedure

; Now for the printing of the message; we will load one byte
; from whatever SI is pointing to
; and copy it to register AL
; check that it is not equal to zero
; and print it to the screen.
; This looks a bit strange but we’re using a special instruction here, lodsb,
; that does several things. It will by default use SI to fetch a byte, store it
; in AL and increment SI by one. Since we have set up SI to point to our
; message we will take one character after the other until we find a byte that
; is zero.
.next:
  lodsb               ; next byte to AL, increment SI
  cmp al, 0           ; if the byte is zero
  je .done            ; jump do done
  int 0x10            ; invoke the BIOS system call
  jmp .next           ; loop

.done:
  jmp $               ; loop forever

; the message we want to print
msg: db 'Hello', 0   ; the string we want to print

;Now for the magic, we need to turn this into a 512-byte sequence with
;a precise master boot record signature ( 0xAA55) at the end.
times 510-($-$$) db 0 ; fill up to 510 bytes
dw 0xAA55             ; master boot record signature
; That’s it, we now have a master boot record.
