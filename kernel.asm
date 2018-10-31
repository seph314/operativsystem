global start

section .text
bits 32
start:  ; We start by declaring the label start as global. This will tell the assembler to leave an entry for this tag in the object fil
  mov dword [0xb8000], 0x2f4b2f4f ; print ‘OK‘ to screen
  hlt
