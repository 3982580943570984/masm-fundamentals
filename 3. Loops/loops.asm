.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib

.data
    m      dd 1230                                          ; �������� ����� m
    k      dd 0                                             ; ������� ����� k
    format db "The largest k where 2*k < m is %d", 10, 0    ; ������ ������ ��� printf

.code
    start:   
             mov    eax, 0                          ; ������������� eax (����� �������������� ��� �������� k)
             mov    ebx, m                          ; �������� m � ebx

    ; ���� ��� ���������� ����������� k, ��� ������� 2*k < m
    find_k:  
             add    eax, 1                          ; ���������� k �� 1
             shl    eax, 1                          ; ��������� k �� 2 (����� ����� �� 1 ���)
             cmp    eax, ebx                        ; ��������� 2*k � m
             jae    end_loop                        ; ���� 2*k >= m, ����� �� �����
             shr    eax, 1                          ; ������� k � ��������� �������� (����� ������ �� 1 ���)
             jmp    find_k                          ; ������� � ��������� �������� �����

    end_loop:
             shr    eax, 1                          ; ������� k � ��������� �������� (���� 2*k >= m)
             mov    k, eax                          ; ���������� ���������� �������� k

    ; ����� ����������
             invoke crt_printf, addr format, eax

    ; ���������� ���������
             invoke ExitProcess, 0

end start
