section .text
global main
extern printf
 
main:
        ; print using printf
        push msg
        call printf
 
        add esp, 4
        ; sys_exit
        mov     eax, 1
        int     0x80
 
section .data
msg db     "Hello, world", 10, 0
len equ     $ - msg