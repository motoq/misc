#include <cstddef>
#include <iostream>
#include <array>

/*
 * Illustrates a template class, operator[] overriding, other class,
 * and utility (external) template functions.
 */


/**
 * Wrapper class around a std::array illustrating template syntax
 * operating on the contents of the class.
 *
 * @tparam  TYPE  The type to be stored by this example container
 * @tparam  DIM   The number of elements held by this example container
 */
template <typename TYPE, std::size_t DIM>
class TemplateArray {
public:
  /**
   * Create an container with all values set to zero for the TYPE.
   *
   * @tparam  TYPE  The type to be stored by this example container
   * @tparam  DIM   The number of elements held by this example container
   */
  TemplateArray();

  /**
   * Create an container with all values set to initVal for the TYPE.
   *
   * @tparam  TYPE  The type to be stored by this example container
   * @tparam  DIM   The number of elements held by this example container
   *
   * @param  initVal  Value used to initialize all elements of the
   *                  container.
   */
  TemplateArray(TYPE initVal);

  /**
   * @return  std::array of elements held by this container.
   */
  std::array<TYPE, DIM> getArray() const;

  /**
   * @param  Index of element to be returned by reference for
   *         modification.
   */
  TYPE& operator[](std::size_t ndx);

  /**
   * @param  Index of element value to be returned by copy.
   */
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

/**
 * Return a subset (slice) of the input container.
 *
 * @tparam  TYPE       The type stored by input and output containers
 * @tparam  DIM        The number of elements held by the input
 *                     container
 * @tparam  DIM_SLICE  The number of elements to be held by the subset
 *                     returned
 *
 * @param  ta      Container from which to pull a subset
 * @param  offset  Offset, zero based, into input container from which
 *                 to start drawing elements.
 *
 * @return  Slice of input container of size DIM_SLICE
 */
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

/**
 * Return the concatenation of the first and second input containers.
 *
 * @tparam  TYPE  The type stored by input and output containers
 * @tparam  DIM1  Size of the first input container
 * @tparam  DIM2  Size of the second input container
 *
 * @param  ta1  First container
 * @param  ta2  Second container
 *
 * @return  DIM1+DIM2 concatenation of the two input containers.
 */
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
 * Illustrates use of the TemplateArray container.
 */
int main()
{
  constexpr std::size_t n {3};
  constexpr std::size_t n2 {n - 1};

  /*
   * Constructors
   */

  TemplateArray<double, n> ta1;
  std::cout << "\nFirst template array";
  printArray(ta1.getArray());

  TemplateArray<double, n> ta2(1.0);
  std::cout << "\nSecond template array";
  printArray(ta2.getArray());

  /*
   * Class functions
   */

  std::cout << "\n\nta2[1]: " << ta2[1];
  ta2[1] = 3.0;
  std::cout << "\nChanged ta2[1]";
  printArray(ta2.getArray());

  /*
   * Utility functions
   */

  std::cout << "\n\nSlice of ta2";
  TemplateArray<double, n2> ta3 = slice<double, n, n2>(ta2, 1);
  printArray(ta3.getArray());

  std::cout << "\n\nta2 and slice of ta2";
  TemplateArray<double, n+n2> ta4 = cat<double, n, n2>(ta2, ta3);
  printArray(ta4.getArray());

  std::cout << '\n';
}





