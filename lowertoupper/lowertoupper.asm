section .text
global main
 
main:
        mov     eax, [esp + 0x08]       ; get argv ptr
        mov     esi, [eax + 0x04]       ; get argv[1]
 
        push    esi                     ; push string for strlen
        call    toUpper                 ; call string length
 
        push    eax                     ; push string length for print
 
        call    print
 
        ; sys_exit
        mov    eax, 1
        int    0x80
 
print:
        push    ebp
        mov     ebp, esp
 
        mov     edx, [ebp+8]
        mov     ecx, [ebp+12]
        mov     eax, 4
        mov     ebx, 1
        int     0x80
        pop     ebp
        ret
 
toUpper:
        push    ebp
        mov     ebp, esp                ;pre amble
 
        mov     ecx, [ebp + 8]
 
        xor     eax, eax                ; length
 
startLoop:
        xor     edx, edx
        mov     dl, byte[ecx]
        inc     eax
 
        cmp     dl, 0x0                 ; check for \0
        je      end                     ; restart loop if not \0
        cmp     dl, 'a'                 ; check bounds
        jb      next
        cmp     dl, 'z'                 ; check bounds
        ja      next
        sub     dl, 0x20                ; convert to uppercase
        mov     [ecx], dl               ; put dl into ecx
 
next:
        inc     ecx
        jmp     startLoop
 
end:
        inc ecx                         ; ecx += 1
        mov     byte[ecx], 0xa          ; add new line
        inc eax                         ; eax += 1
        pop     ebp                     ; clean up
        ret      