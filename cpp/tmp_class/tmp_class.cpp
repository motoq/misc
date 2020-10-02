#include <cstddef>
#include <iostream>
#include <array>

template <typename TYPE, std::size_t DIM>
class StdArrayTest {
public:
  StdArrayTest();
  StdArrayTest(TYPE initVal);

  std::array<TYPE, DIM> getArray() const;

private:
  std::array<TYPE, DIM> a;
};
  

template <typename TYPE, std::size_t DIM>
StdArrayTest<TYPE, DIM>::StdArrayTest()
{
  TYPE def_val = static_cast<TYPE>(0);
  for (std::size_t ii=static_cast<TYPE>(0); ii<DIM; ++ii) {
    a[ii] = def_val;
  }
}

template <typename TYPE, std::size_t DIM>
StdArrayTest<TYPE, DIM>::StdArrayTest(TYPE def_val)
{
  for (std::size_t ii=static_cast<TYPE>(0); ii<DIM; ++ii) {
    a[ii] = def_val;
  }
}

template <typename TYPE, std::size_t DIM>
std::array<TYPE, DIM> StdArrayTest<TYPE, DIM>::getArray() const
{
  return a;
}

template <typename TYPE, std::size_t DIM>
void printArray(const std::array<TYPE, DIM>& a2p)
{
  std::cout << '\n';
  for (std::size_t ii=static_cast<TYPE>(0); ii<DIM; ++ii) {
    std::cout << ' ' << a2p[ii];
  }
}

/**
 *
 * @author  Kurt Motekew
 */
int main()
{
  constexpr std::size_t n {3};

  StdArrayTest<double, n> sat0;
  auto a0 = sat0.getArray();
  printArray(a0);

  StdArrayTest<double, n> sat1(1.0);
  auto a1 = sat1.getArray();
  printArray(a1);

  std::cout << '\n';
}





