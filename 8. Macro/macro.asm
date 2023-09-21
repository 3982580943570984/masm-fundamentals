.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib

.const
    prompt db "Input x: ", 0
    result db "Output x: %d", 0
    format db "%u", 0

.data
    X             dd  0                 ; ������ ��������

    ; ������ ��� ������� ������ �������� ����� ���������
SetEvenBits macro reg
                              or reg, 55555555h
ENDM

    ; ������ ��� ������� ����� �� 8
DivideByEight macro reg
                                shr reg, 3
ENDM

    ; ������ ��� ������ ������ � ����� ����� �����
SwapHalves macro reg
                             mov eax, reg
                             rol eax, 16
                             mov reg, eax
ENDM


.code
    start:

    ; ��������� �������� ����� X
          invoke        crt_printf, addr prompt
          invoke        crt_scanf, addr format, addr X

    ; ���������� ������� ��� ���������� ��������
          SetEvenBits   X
          DivideByEight X
          SwapHalves    X

    ; ���������� ���������
          invoke        crt_printf, addr result, addr format, X
          invoke        ExitProcess, 0

end start
