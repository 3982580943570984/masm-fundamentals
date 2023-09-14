.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib

.const
      promptA           db "Введите значение для a: ", 0
      promptB           db "Введите значение для b: ", 0
      promptC           db "Введите значение для c: ", 0

      formatContains    db "%hu находится в диапазоне [1, 10]", 10, 0
      formatWord        db "%hu", 0

.data?
      a_                dw ?
      b_                dw ?
      c_                dw ?

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

      ; Parse a
            mov    ax, a_
            cmp    ax, 1
            jl     skip1
            cmp    ax, 10
            jg     skip1
            invoke crt_printf, addr format, ax
            add    esp, 8

      ; Parse b
      skip1:
            mov    ax, b_
            cmp    ax, 1
            jl     skip2
            cmp    ax, 10
            jg     skip2
            invoke crt_printf, addr format, ax
            add    esp, 8

      ; Parse c
      skip2:
            mov    ax, c_
            cmp    ax, 1
            jl     skip3
            cmp    ax, 10
            jg     skip3
            invoke crt_printf, addr format, ax
            add    esp, 8
      
      ; Exit
      skip3:
            invoke ExitProcess, 0

end start
