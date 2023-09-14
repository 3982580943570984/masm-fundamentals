.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\msvcrt.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\msvcrt.lib
includelib \masm32\lib\kernel32.lib

.const
    promptSize    db "Enter size of the array: ", 0
    promptElement db "Enter element %hu: ", 0
    formatDword   db "%hu"
    
.data?
    size_         dd ?
    array_        dd ?

.code
    start:     
    ;Get the size of the array
               invoke crt_printf, addr promptSize
               invoke crt_scanf, addr formatDword, size_

    ; Allocate memory for the array
               invoke HeapCreate, 0, 0, 0
               mov    ebx, eax
               mov    ecx, size_
               shl    ecx, 2
               invoke HeapAlloc, ebx, 0, ecx
               mov    array_, eax

               mov    ecx, 0
    input_loop:
               cmp    ecx, size_
               jge    end_input

               invoke crt_printf, addr promptElement, ecx
               lea    edx, [array_ + ecx*4]
               invoke crt_scanf, addr formatDword, edx

               inc    ecx
               jmp    input_loop
    
    end_input: 
          

    ; Free the allocated memory
               invoke HeapFree, ebx, 0, array_
               invoke HeapDestroy, ebx

    ; Exit program
               invoke ExitProcess, 0
end start
