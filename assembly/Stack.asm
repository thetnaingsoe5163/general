Section .data
enterNextLine   db      0x0A

SECTION .bss
byteStack       resb    20
stackPointer    resb    1

SECTION .text
global _start

_start:
    mov     eax, byteStack
    movzx   ebx, byte [stackPointer]
   
    mov     al, 0x41
    movzx   esi, al
    call    push
    call    display

    mov     al, 0x42
    movzx   esi, al
    call    push
    call    display

    call    pop
    call    display

    mov     al, 0x5A
    movzx   esi, al
    call    push
    call    display

    mov     ebx, 0
    mov     eax, 1
    int     80h

display:
    mov     edx, 20
    mov     ecx, byteStack
    mov     ebx, 1
    mov     eax, 4
    int     80h

    mov     edx, 1
    mov     ecx, enterNextLine
    mov     ebx, 1
    mov     eax, 4
    int     80h
    ret

push:
    mov     [byteStack + ebx], esi
    inc     ebx
    mov     [stackPointer], bl
    ret

pop:
    mov     byte [byteStack + ebx], 0x20
    dec     ebx
    mov     [stackPointer], bl
    ret