.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib

.const
    prompt db "Input value of x: ", 0
    result db "Output value of x: %d", 0
    format db "%u", 0

.data
                  X   dd 0    ; Пример значения

    ; Макрос для задания четных разрядов числа единицами
SetEvenBits macro reg
                              or  reg, 55555555h
ENDM

    ; Макрос для деления числа на 8
DivideByEight macro reg
                                shr reg, 3
ENDM

    ; Макрос для обмена правой и левой части числа
SwapHalves macro reg
                             mov eax, reg
                             and eax, 0000FFFFh
                             shl eax, 16

                             mov ebx, reg
                             and ebx, 4294901760
                             shr ebx, 16

                             or   eax, ebx
                             mov reg, eax
ENDM

.code
    start:

    ; Считываем значение числа X
          invoke crt_printf, addr prompt
          invoke crt_scanf, addr format, addr X

    ; Используем макросы для выполнения операций
          SetEvenBits   X
          DivideByEight X
          SwapHalves    X

    ; Завершение программы
          invoke crt_printf, addr result, addr format, X
          invoke ExitProcess, 0

end start
