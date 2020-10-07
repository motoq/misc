#include <cstddef>
#include <iostream>
#include <array>

template <typename TYPE, std::size_t DIM>
class TemplateArray {
public:
  TemplateArray();
  TemplateArray(TYPE initVal);

  std::array<TYPE, DIM> getArray() const;

  TYPE& operator[](std::size_t ndx);
  TYPE operator[](std::size_t ndx) const;

private:
  std::array<TYPE, DIM> a;
};
  

template <typename TYPE, std::size_t DIM>
TemplateArray<TYPE, DIM>::TemplateArray()
{
  TYPE def_val = static_cast<TYPE>(0);
  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM; ++ii) {
    a[ii] = def_val;
  }
}

template <typename TYPE, std::size_t DIM>
TemplateArray<TYPE, DIM>::TemplateArray(TYPE def_val)
{
  for (std::size_t ii=static_cast<size_t>(0); ii<DIM; ++ii) {
    a[ii] = def_val;
  }
}

template <typename TYPE, std::size_t DIM>
std::array<TYPE, DIM> TemplateArray<TYPE, DIM>::getArray() const
{
  return a;
}

template <typename TYPE, std::size_t DIM>
TYPE& TemplateArray<TYPE, DIM>::operator[](std::size_t ndx)
{
  return a[ndx];
}

template <typename TYPE, std::size_t DIM>
TYPE TemplateArray<TYPE, DIM>::operator[](std::size_t ndx) const
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
TemplateArray<TYPE, DIM_SLICE>
slice(const TemplateArray<TYPE, DIM>& ta, std::size_t offset)
{
  TemplateArray<TYPE, DIM_SLICE> taslc;

  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM_SLICE; ++ii) {
    taslc[ii] = ta[ii+offset];
  }

  return taslc;
}

template <typename TYPE, std::size_t DIM1, std::size_t DIM2>
TemplateArray<TYPE, DIM1+DIM2>
cat(const TemplateArray<TYPE, DIM1>& ta1,
    const TemplateArray<TYPE, DIM2>& ta2)
{
  TemplateArray<TYPE, DIM1 + DIM2> ta3;

  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM1; ++ii) {
    ta3[ii] = ta1[ii];
  }
  for (std::size_t ii=static_cast<std::size_t>(0); ii<DIM2; ++ii) {
    ta3[ii+DIM1] = ta2[ii];
  }

  return ta3;
}


/**
 *
 * @author  Kurt Motekew
 */
int main()
{
  constexpr std::size_t n {3};
  constexpr std::size_t n2 {n - 1};

  TemplateArray<double, n> ta1;
  std::cout << "\nFirst template array";
  printArray(ta1.getArray());

  TemplateArray<double, n> ta2(1.0);
  std::cout << "\nSecond template array";
  printArray(ta2.getArray());

  std::cout << "\n\nta2[1]: " << ta2[1];
  ta2[1] = 3.0;
  std::cout << "\nChanged ta2[1]";
  printArray(ta2.getArray());

  std::cout << "\n\nSlice of ta2";
  TemplateArray<double, n2> ta3 = slice<double, n, n2>(ta2, 1);
  printArray(ta3.getArray());

  std::cout << "\n\nta2 and slice of ta2";
  TemplateArray<double, n+n2> ta4 = cat<double, n, n2>(ta2, ta3);
  printArray(ta4.getArray());

  std::cout << '\n';
}





