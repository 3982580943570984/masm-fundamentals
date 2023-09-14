.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib

.const
    promptM     db "Enter value for m: ", 0
    outputM     db "Entered m: %hu", 10, 0
    formatDword db "%hu", 0
    formatRes   db "The largest k for which 2*k < m: %hu", 10, 0    ; Format string for printf

.data
    k_   dd 0    ; Desired number k

.data?
    m_   dd ?    ; Given number m

.code
    start:   
    ; Get input for a
             invoke crt_printf, addr promptM
             invoke crt_scanf, addr formatDword, addr m_
             invoke crt_printf, addr outputM, m_

             mov    eax, 0                                  ; Initialize eax (will be used to store k)
             mov    ebx, m_                                 ; Load m into ebx

    ; Loop to find the largest k for which 2*k < m
    find_k:  
             add    eax, 1                                  ; Increase k by 1
             shl    eax, 1                                  ; Multiply k by 2 (shift left by 1 bit)
             cmp    eax, ebx                                ; Compare 2*k with m
             jae    end_loop                                ; If 2*k >= m, exit the loop
             shr    eax, 1                                  ; Return k to its original value (shift right by 1 bit)
             jmp    find_k                                  ; Jump to the next loop iteration

    end_loop:
             shr    eax, 1                                  ; Return k to its original value (if 2*k >= m)
             mov    k_, eax                                 ; Save the found value of k

    ; Output the result
             invoke crt_printf, addr formatRes, k_

    ; End the program
             invoke ExitProcess, 0

end start
