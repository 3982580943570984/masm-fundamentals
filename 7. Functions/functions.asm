.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
    prompt      db "Input string: ", 0
    s1Label     db "String S1 (letters): ", 0
    s2Label     db "String S2 (numbers): ", 0
    inputString db 256 dup(0)
    s1          db 256 dup(0)
    s2          db 256 dup(0)

.code

InputString PROC
                  invoke StdOut, addr prompt
                  invoke StdIn, addr inputString, 255
                  ret
InputString ENDP

ProcessChar PROC
    ; Инициализация индексов для строк S1 и S2
                  xor    ecx, ecx                        ; индекс для S1
                  xor    edx, edx                        ; индекс для S2

    ; Пройтись по каждому символу строки
                  mov    esi, offset inputString
    processLoop:  
                  mov    al, [esi]
                  test   al, al                          ; Проверка на конец строки
                  jz     done

    ; Проверка на букву
                  cmp    al, 'A'
                  jl     isDigit
                  cmp    al, 'Z'
                  jle    isLetter
                  cmp    al, 'a'
                  jl     isDigit
                  cmp    al, 'z'
                  jg     isDigit

    isLetter:     
                  mov    [s1 + ecx], al
                  inc    ecx
                  jmp    nextChar

    isDigit:      
                  cmp    al, '0'
                  jl     nextChar
                  cmp    al, '9'
                  jg     nextChar
                  mov    [s2 + edx], al
                  inc    edx

    nextChar:     
                  inc    esi
                  jmp    processLoop

    done:         
                  ret
ProcessChar ENDP

OutputResults PROC
    ; Вывести строки S1 и S2
                  invoke StdOut, addr s1Label
                  invoke StdOut, addr s1
                  invoke StdOut, addr s2Label
                  invoke StdOut, addr s2
                  ret
OutputResults ENDP

    start:        
                  call   InputString
                  call   ProcessChar
                  call   OutputResults

    ; Завершение программы
                  invoke ExitProcess, 0

end start
