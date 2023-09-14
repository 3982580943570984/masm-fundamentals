#include <algorithm>
#include <array>
#include <format>
#include <iostream>
#include <vector>

const char format[] = "\t%d находится в диапазоне [1, 10]";

auto calculation(int a, int b, int c) {
  __asm {
      mov eax, a
      cmp eax, 1
      jl skip1
      cmp eax, 10
      jg skip1
      push eax
      push offset format
      call printf
      add esp, 8

    skip1:
      mov eax, b
      cmp eax, 1
      jl skip2
      cmp eax, 10
      jg skip2
      push eax
      push offset format
      call printf
      add esp, 8

    skip2:
      mov eax, c
      cmp eax, 1
      jl skip3
      cmp eax, 10
      jg skip3
      push eax
      push offset format
      call printf
      add esp, 8

    skip3:
  }
}

int main(int argc, char *argv[]) {

  const std::vector<std::array<int, 3>> tests{
      {5, 5, 5}, // Все числа в середине диапазона
      {1, 10, 5}, // Все числа на краях и в середине диапазона
      {0, 11, 12}, // Все числа чуть за пределами диапазона
      {-10, -11, -12}, // Все числа отрицательные и вне диапазона
      {10, 9, 8}, // Все числа в диапазоне, но в убывающем порядке
      {1, 2, 3}, // Все числа в диапазоне, но в возрастающем порядке
      {2147483647, 0, -2147483647}, // Крайний случай: INT_MAX, 0, INT_MIN + 1
      {5, 0, 11}, // Одно число в диапазоне, один ноль, одно чуть выше диапазона
      {1, 0, -1}, // Одно число в диапазоне, один ноль, одно чуть ниже диапазона
      {10, 11, 9} // Числа вокруг верхнего края диапазона
  };

  std::for_each(tests.cbegin(), tests.cend(), [&](const auto &test) {
    const auto &[a, b, c]{test};
    std::cout << std::format("Запуск теста с входными данными: {}, {}, {}\n", test[0],
                             test[1], test[2]);
    calculation(a, b, c);
    std::cout << "Конец теста\n\n";
  });

  return 0;
}
