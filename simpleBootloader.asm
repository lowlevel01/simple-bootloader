; 16 bit mode so NASM should generate code accordingly
bits 16

; the bootloader starts at the adress 0x7c00 so the next line replaces adding the offset 0x7c00 each time
org 0x7c00

; setting the colors for background and foreground
mov ah, 0x06 ; built-in functions can be controlled by putting a bytes in the ah register, this one to clear the screen
xor al, al
xor cx, cx
mov dx, 0x184f
mov bh, 0xf1
int 0x10

;moving what we want to print on the screen to si register
mov si, output
; 0x0e to ah means writing in TTY mode
mov ah, 0x0e
loop:
    lodsb
    test al, al ; checking if al is a nullbyte which means it's the end of a string
    ; if so then the bootloader is stopped
    jz end
    int 0x10
    jmp loop
end:
    hlt
output: db "EXAMPLE OF A SIMPLE BOOTLOADER", 0x0a, " s/o CIT - INPT", 0x00

; the next line is to fill the bootloader with nullbytes 0x00 in order to reach 512 bytes
times 510 - ($-$$) db 0

;every bootloader must end with bytes 0xaa and 0x55
dw 0xaa55
