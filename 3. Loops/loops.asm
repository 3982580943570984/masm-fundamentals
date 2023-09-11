.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib

.data
    m      dd 1230                                          ; Заданное число m
    k      dd 0                                             ; Искомое число k
    format db "The largest k where 2*k < m is %d", 10, 0    ; Формат строки для printf

.code
    start:   
             mov    eax, 0                          ; Инициализация eax (будет использоваться для хранения k)
             mov    ebx, m                          ; Загрузка m в ebx

    ; Цикл для нахождения наибольшего k, при котором 2*k < m
    find_k:  
             add    eax, 1                          ; Увеличение k на 1
             shl    eax, 1                          ; Умножение k на 2 (сдвиг влево на 1 бит)
             cmp    eax, ebx                        ; Сравнение 2*k с m
             jae    end_loop                        ; Если 2*k >= m, выход из цикла
             shr    eax, 1                          ; Возврат k к исходному значению (сдвиг вправо на 1 бит)
             jmp    find_k                          ; Переход к следующей итерации цикла

    end_loop:
             shr    eax, 1                          ; Возврат k к исходному значению (если 2*k >= m)
             mov    k, eax                          ; Сохранение найденного значения k

    ; Вывод результата
             invoke crt_printf, addr format, eax

    ; Завершение программы
             invoke ExitProcess, 0

end start
