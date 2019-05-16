section .text
global _start
 
_start:
        ; sys_open
        mov     eax, 5
        mov     edx, 0666o
        mov     ebx, fname
        mov     ecx, 0102o
        int     0x80
 
        ; sys_write
        mov     edx, len
        mov     ecx, msg
        mov     ebx, eax
        mov     eax, 4
        int     0x80
 
        ; sys_exit
        mov     eax, 1
        int     0x80
 
section .data
msg db     "Hello, world", 10, 0
len equ     $ - msg
fname db    "hello.txt", 0