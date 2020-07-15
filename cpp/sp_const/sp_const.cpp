#include <iostream>
#include <memory>

void print_sp(std::shared_ptr<int> in);
void print_csp(const std::shared_ptr<int>& in);
//void print_spc(std::shared_ptr<int>& const in);

/**
 */
int main() {
  auto foo = std::make_shared<int>(10);
  //*foo = 10;

  print_sp(foo);

  std::cout << '\n';
}

void print_sp(std::shared_ptr<int> in)
{
  std::cout << '\n' << *in;
}

void print_csp(const std::shared_ptr<int>& in)
{
  std::cout << '\n' << *in;
}

/*
 * Illustrate pointer count affected pointed to memory
 *
 * error: ‘const’ qualifiers cannot be applied to ‘std::shared_ptr<int>&’
void print_spc(std::shared_ptr<int>& const in)
{
  std::cout << '\n' << *in;
}
*/
