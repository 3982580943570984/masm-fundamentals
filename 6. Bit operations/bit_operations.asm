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
    X    dd 0    ; ����� ����� ������ ��������� �������� X

.code
    start:
    ; ��������� �������� ����� X
          invoke crt_printf, addr prompt
          invoke crt_scanf, addr format, addr X

    ; ������ ������ ������� ����� X ���������
          mov    eax, X
          or     eax, 55555555h

    ; ����� ���������� �������� �� 8
          shr    eax, 3

    ; �������� ������� ������ � ����� ����� ����������
    ; ��� ����� �������� ����� �� ��� 16-������ ����� � �������� �� �������
          rol    eax, 16
          mov    X, eax

    ; ���������� ���������
          invoke crt_printf, addr result, addr format, X
          invoke ExitProcess, 0

end start