#include <cstddef>
#include <iostream>
#include <array>

template <typename TYPE, std::size_t DIM>
class StdArrayTest {
public:
  StdArrayTest();
  StdArrayTest(TYPE initVal);

  std::array<TYPE, DIM> getArray() const;

  TYPE& operator[](std::size_t ndx);
  TYPE operator[](std::size_t ndx) const;

private:
  std::array<TYPE, DIM> a;
};
  

template <typename TYPE, std::size_t DIM>
StdArrayTest<TYPE, DIM>::StdArrayTest()
{
  TYPE def_val = static_cast<TYPE>(0);
  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM; ++ii) {
    a[ii] = def_val;
  }
}

template <typename TYPE, std::size_t DIM>
StdArrayTest<TYPE, DIM>::StdArrayTest(TYPE def_val)
{
  for (std::size_t ii=static_cast<size_t>(0); ii<DIM; ++ii) {
    a[ii] = def_val;
  }
}

template <typename TYPE, std::size_t DIM>
std::array<TYPE, DIM> StdArrayTest<TYPE, DIM>::getArray() const
{
  return a;
}

template <typename TYPE, std::size_t DIM>
TYPE& StdArrayTest<TYPE, DIM>::operator[](std::size_t ndx)
{
  return a[ndx];
}

template <typename TYPE, std::size_t DIM>
TYPE StdArrayTest<TYPE, DIM>::operator[](std::size_t ndx) const
{
  return a[ndx];
}

template <typename TYPE, std::size_t DIM>
void printArray(const std::array<TYPE, DIM>& a2p)
{
  std::cout << '\n';
  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM; ++ii) {
    std::cout << ' ' << a2p[ii];
  }
}

template <typename TYPE, std::size_t DIM, std::size_t DIM_SLICE>
StdArrayTest<TYPE, DIM_SLICE>
slice(const StdArrayTest<TYPE, DIM>& sat1, std::size_t offset)
{
  StdArrayTest<TYPE, DIM_SLICE> sat2;

  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM_SLICE; ++ii) {
    sat2[ii] = sat1[ii+offset];
  }

  return sat2;
}

template <typename TYPE, std::size_t DIM1, std::size_t DIM2>
StdArrayTest<TYPE, DIM1+DIM2>
cat(const StdArrayTest<TYPE, DIM1>& sat1,
    const StdArrayTest<TYPE, DIM2>& sat2)
{
  StdArrayTest<TYPE, DIM1 + DIM2> sat3;

  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM1; ++ii) {
    sat3[ii] = sat1[ii];
  }
  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM2; ++ii) {
    sat3[ii+DIM1] = sat2[ii];
  }

  return sat3;
}


/**
 *
 * @author  Kurt Motekew
 */
int main()
{
  constexpr std::size_t n {3};
  constexpr std::size_t n2 {n - 1};

  StdArrayTest<double, n> sat0;
  auto a0 = sat0.getArray();
  printArray(a0);

  StdArrayTest<double, n> sat1(1.0);
  auto a1 = sat1.getArray();
  printArray(a1);

  std::cout << "\nsat1[1]: " << sat1[1];
  sat1[1] = 3.0;
  std::cout << "\nChanged sat1[1]: " << sat1[1];

  StdArrayTest<double, n2> sat2 = slice<double, n, n2>(sat1, 1);
  printArray(sat2.getArray());

  StdArrayTest<double, n+n2> sat3 = cat<double, n, n2>(sat1, sat2);
  printArray(sat3.getArray());

  std::cout << '\n';
}





