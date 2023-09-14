.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib

.const
	promptA     db "Введите значение для a: ", 0
	promptB     db "Введите значение для b: ", 0
	promptC     db "Введите значение для c: ", 0
	resultStr   db "Результирующий x: %lu", 0
	
	formatWord  db "%hu", 0
	formatDword db "%u", 0

.data?
	a_          dw ?
	b_          dw ?
	c_          dw ?
	x_          dd ?

.code
	start:
	; Get input for a
	      invoke crt_printf, addr promptA
	      invoke crt_scanf, addr formatWord, addr a_

	; Get input for b
	      invoke crt_printf, addr promptB
	      invoke crt_scanf, addr formatWord, addr b_

	; Get input for c
	      invoke crt_printf, addr promptC
	      invoke crt_scanf, addr formatWord, addr c_

	; Calculate X = 5a + cb
	      mov    ax, a_
	      imul   ax, 5
	      mov    bx, c_
	      imul   bx, b_
	      add    ax, bx
	      mov    x_, eax

	; Display result
	      invoke crt_printf, addr resultStr, x_

	; Exit
	      invoke ExitProcess, 0

end start
