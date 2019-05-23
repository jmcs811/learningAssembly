section .text
global main
 
main:
        push    prompt1             ; push prompt1
        push    prompt1Len          ; push length
        call    print               ; call print
 
        mov     ecx, num1           ; buffer into to ecx
        mov     edx, 9              ; set the length
        call    read                ; call read
        mov     [num1len], eax      ; mov the length of input to num1len buffer    
 
        mov     edx, num1           ; move buffer into edx
        call    stringToNum         ; convert from string to int
        mov     esi, eax            ; put the converted num into esi
 
        push    prompt2             ; push prompt1
        push    prompt2Len          ; push length
        call    print               ; call print
 
        mov     ecx, num2           ; buffer into ecx
        mov     edx, 9              ; set the length
        call    read                ; call read
        mov     [num2len], eax      ; mov lenght of input into num2len buffer
 
        mov     edx, num2           ; mov buffer into edx
        call    stringToNum         ; convert from string to int
        mov     edi, eax            ; put the converted num into edi
 
        cmp     esi, edi            ; compare the ints
        jl      printNum2           ; print num2 if greater
        jg      printNum1           ; print num1 if greater
        je      equal               ; print equal if equal
 
        ; close
        jmp     exit                ; sys_exit
 
printNum2:
        push    num2                ; push string input onto stack
        push    dword [num2len]     ; push len on the stack
        call    print               ; print to stdout

        jmp     exit                ; sys_exit
 
printNum1:
        push    num1                ; push string input onto stack
        push    dword [num1len]     ; push len on the stack
        call    print               ; print to stdout

        jmp     exit                ; sys_exit
       
equal:
        push    equalMsg            ; push equal message onto stack
        push    equalMsgLen         ; push the len of message onto stack
        call    print               ; print message to stdout
 
        jmp     exit                ; sys_exit
 
exit:
        mov     eax, 1              
        mov     ebx, 0
        int     0x80                ; sys_exit call
 
print:
        push    ebp
        mov     ebp, esp            ; pre-amble (setting up stack)
 
        mov     edx, [ebp+8]        ; grab the string
        mov     ecx, [ebp+12]       ; grab the length of the string
        mov     eax, 4
        mov     ebx, 1
        int     0x80                ; sys_write
 
        mov     esp, ebp            ; cleaning up the stack
        pop     ebp
        ret
 
read:
        push    ebp
        mov     ebp, esp
 
        mov     eax, 3
        mov     ebx, 0
        int     0x80
       
        mov     esp, ebp
        pop     ebp
        ret
 
; move string to edx
stringToNum:
        xor     eax, eax            ; zero out eax
 
.top:
        movzx   ecx, byte [edx]     ; get 1 char of the string into ecx
        inc     edx                 ; increment ecx to get next char
 
        cmp     ecx, '0'            
        jb      .done
        cmp     ecx, '9'
        ja      .done
        sub     ecx, '0'            ; convert to int
        imul    eax, 10             ; mul by 10 
        add     eax, ecx            ; add 
        jmp     .top                ; start over for next char
 
.done:
        ret
 
section .data
        num1:    times   9     db  0             ; allocate 9 byte buffer
        num2:    times   9     db  0             ; allocate 9 byte buffer    
        num1len: times   4     db  0             ; to store length of the input
        num2len: times   4     db  0             ; to store length of the input
       
        prompt1 db      'Enter first Number: '
        prompt1Len equ $-prompt1

        prompt2 db      'Enter second Number: '
        prompt2Len equ $-prompt2

        equalMsg  db     'Numbers are equal', 10, 0
        equalMsgLen equ $-equalMsg