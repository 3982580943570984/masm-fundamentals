#include <iostream>

int main() {
    const int n{ 10 };
    int sarray[n]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 };
    int darray[n]{ 0 };

    __asm {
        mov ecx, n
        dec ecx
        
        lea esi, sarray
        lea edi, darray

    process_loop:
        mov eax, [esi + ecx * 4]
        mov [edi], eax
        add edi, 4
        dec ecx
        cmp ecx, -1
        jnz process_loop
    }

    for (const auto& e : darray) {
        std::cout << e << ' ';
    }
    std::cout << std::endl;

    return 0;
}
