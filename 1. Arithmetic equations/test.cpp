#include <algorithm>
#include <array>
#include <format>
#include <iostream>
#include <vector>

auto calculation(int a, int b, int c) {
  std::cout << std::format("Входные данные: a = {}, b = {}, c = {}\n", a, b, c);

  int result;
  __asm {
    mov  eax, a
    imul eax, 5

    mov  ebx, c
    imul ebx, b

    add  eax, ebx

    mov  result, eax
  }

  std::cout << std::format("Результат = {}\n", result);

  return result == (a * 5 + b * c);
}

int main() {
  const std::vector<std::array<int, 3>> tests{
      {1, 1, 1},          {0, 0, 0},          {-1, -1, -1},       {2, -3, 4},
      {1000, 1000, 1000}, {2147483647, 1, 1}, {-2147483647, 1, 1}};

  auto iteration_number{0};
  std::for_each(tests.cbegin(), tests.cend(), [&](const auto &test) {
    const auto &[a, b, c]{test};
    auto is_passed{calculation(a, b, c)};
    std::cout << std::format("Тест #{} {} \n\n", iteration_number++,
                             (is_passed ? "пройден" : "не пройден"));
  });

  return 0;
}
