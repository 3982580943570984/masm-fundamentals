.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\msvcrt.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\msvcrt.lib
includelib \masm32\lib\kernel32.lib

.data
    srcArray  dd 1, 2, 3, 4, 5
    destArray dd 5 dup(0)
    arraySize dd 5
    format    db "%d ", 0

.code
    start:       
    ; Initialize pointers
                 lea    esi, srcArray
                 lea    edi, destArray

    ; Load arraySize into ecx as the counter
                 mov    ecx, arraySize

    ; Calculate the position of the last element in destArray
                 lea    edi, [edi + 4 * (ecx - 1)]

    reverse_loop:
    ; Copy element from srcArray to destArray
                 mov    eax, [esi]
                 mov    [edi], eax

    ; Move to the next element in srcArray
                 add    esi, 4

    ; Move to the previous element in destArray
                 sub    edi, 4

    ; Decrement counter and check for loop end
                 dec    ecx
                 jnz    reverse_loop

    ; Reset edi to the start of destArray and reload counter
                 lea    edi, destArray
                 mov    ecx, arraySize

    print_loop:  
    ; Print each element in destArray
                 mov    eax, [edi]
                 push   eax
                 push   offset format
                 call   crt_printf
                 add    esp, 8

    ; Move to the next element in destArray
                 add    edi, 4

    ; Decrement counter and check for loop end
                 dec    ecx
                 jnz    print_loop

    ; Exit program
                 invoke ExitProcess, 0
end start
