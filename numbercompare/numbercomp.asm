section .text
global main
 
main:
        push    prompt1             ; push prompt1
        push    prompt1Len          ; push length
        call    print               ; call print
 
        call    read                ; call read
 
        mov     esi, str
        ;sub     byte [esi], 0x30
 
        push    prompt2             ; push prompt1
        push    prompt2Len          ; push length
        call    print               ; call print
 
        call    read
        mov     edi, str
        ;sub     byte [edi], 0x30
 
        push    esi                 ; push int val of input
        push    eax                 ; push num of read bytes
 
        call    print               ; print
        
 
        ; close
        mov     eax, 1
        mov     ebx, 0
        int     0x80
 
print:
        push    ebp
        mov     ebp, esp
 
        mov     edx, [ebp+8]
        mov     ecx, [ebp+12]
        mov     eax, 4
        mov     ebx, 1
        int     0x80
        mov     esp, ebp
        pop     ebp
        ret
 
read:
        push    ebp
        mov     ebp, esp
 
        mov     eax, 3
        mov     ebx, 0
        mov     ecx, str
        mov     edx, 100
        int     0x80
       
        mov     esp, ebp
        pop     ebp
        ret
 
stringlen:
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
        cmp     dl, 'a'
        jb      next
        cmp     dl, 'z'
        ja      next
        sub     dl, 0x20
        mov     [ecx], dl
 
next:
        inc     ecx
        jmp     startLoop
 
end:
        inc ecx
        mov     byte[ecx], 0xa
        inc eax
        pop     ebp
        ret      
 
section .data
        str:    times   100     db  0             ; allocate 100 byte buffer
        lf:     db      10                   ; new line for full buffer
        prompt1 db      'Enter first Number: '
        prompt1Len equ $-prompt1
        prompt2 db      'Enter second Number: '
        prompt2Len equ $-prompt2