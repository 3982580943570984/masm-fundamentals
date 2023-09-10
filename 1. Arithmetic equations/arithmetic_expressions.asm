.386
.model flat, stdcall
option casemap:none

include windows.inc
include kernel32.inc
include masm32.inc
include user32.inc

includelib kernel32.lib
includelib masm32.lib
includelib user32.lib

; 'db' - define byte
; ', 0' - adding null-terminator
.const
    promptA db "Enter value for a: ", 0
    promptB db "Enter value for b: ", 0
    promptC db "Enter value for c: ", 0
    formatStr db "%u", 0
    resultStr db "Result X = %u", 0

; contains uninitialized variables
.data?
    a WORD ?
    b WORD ?
    c_ WORD ?
    x DWORD ?

.code
start:
    ; Get input for a
    invoke StdOut, addr promptA
    invoke StdIn, addr a, sizeof a
    invoke atodw, addr a
    mov a, ax
    invoke StdOut, addr a

    ; Get input for b
    invoke StdOut, addr promptB
    invoke StdIn, addr b, sizeof b
    invoke atodw, addr b
    mov b, ax

    ; Get input for c
    invoke StdOut, addr promptC
    invoke StdIn, addr c_, sizeof c_
    invoke atodw, addr c_
    mov c_, ax

    ; Calculate X = 5a + cb
    mov ax, a
    imul ax, 5
    mov bx, c_
    imul bx, b
    add ax, bx
    mov x, eax

    ; Display result
    ; invoke printf, addr resultStr, addr formatStr, x
    invoke StdOut, addr resultStr

    ; Exit
    invoke ExitProcess, 0

end start

