.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\msvcrt.lib

.const
	promptA     db "Enter value for a: ", 0
	promptB     db "Enter value for b: ", 0
	promptC     db "Enter value for c: ", 0
	formatWord  db "%hu", 0
	formatDword db "%lu", 0
	resultStr   db "Result X = %lu", 0

.data?
	a           dw ?
	b           dw ?
	c_          dw ?
	x           dd ?

.code
	start:
	; Get input for a
	      invoke crt_printf, addr promptA
	      invoke crt_scanf, addr formatWord, addr a

	; Get input for b
	      invoke crt_printf, addr promptB
	      invoke crt_scanf, addr formatWord, addr b

	; Get input for c
	      invoke crt_printf, addr promptC
	      invoke crt_scanf, addr formatWord, addr c_

	; Calculate X = 5a + cb
	      mov    ax, a
	      imul   ax, 5
	      mov    bx, c_
	      imul   bx, b
	      add    ax, bx
	      mov    x, eax

	; Display result
	      invoke crt_printf, addr resultStr, x

	; Exit
	      invoke ExitProcess, 0

end start
