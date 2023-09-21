.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\msvcrt.lib

.data
    prompt       db "Введите строку (только буквы и цифры):", 0
    formatString db "%s", 0
    outputFormat db "Буквы: %s, Цифры: %s", 0
    
    inputString  db 256 dup(0)
    letters      db 256 dup(0)
    digits       db 256 dup(0)

.code
    start:      
    ; Get input string from user
                invoke crt_printf, addr prompt
                invoke StdIn, addr inputString, 256
                
    ; Process the string
                lea    esi, inputString
                lea    edi, letters
                lea    ebx, digits

    processLoop:
    ; Load byte from input string
                mov    al, byte ptr [esi]

    ; Check if end of string
                test   al, al
                jz     done

    ; Check if it's a letter (A-Z or a-z)
                cmp    al, 'A'
                jl     checkDigit
                cmp    al, 'Z'
                jle    storeLetter
                cmp    al, 'a'
                jl     checkDigit
                cmp    al, 'z'
                jg     checkDigit

    storeLetter:
                mov    [edi], al
                inc    edi
                jmp    nextChar

    checkDigit: 
    ; Check if it's a digit (0-9)
                cmp    al, '0'
                jl     nextChar
                cmp    al, '9'
                jg     nextChar

    ; Store digit
                mov    [ebx], al
                inc    ebx

    nextChar:   
    ; Move to the next character
                inc    esi
                jmp    processLoop

    done:       
    ; Null-terminate the letters and digits strings
                mov    byte ptr [edi], 0
                mov    byte ptr [ebx], 0

    ; Print the results
                invoke wsprintf, addr inputString, addr outputFormat, addr letters, addr digits
                invoke StdOut, addr inputString

    ; Exit
                invoke ExitProcess, 0

end start
