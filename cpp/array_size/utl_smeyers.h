#include <cstddef>
#include <iostream>

/**
 * The arraySize utility function from "Effective Modern C++ by Scott Meyers
 * (O'Reilly).  Copyright 2015 Scott Meyers, 978-1-491-90399-5."
 *
 * @param    An array.  Note, the array does not need to be a constexpr.
 *
 * @return   Size of an array as a compile-time constant.
 */
template<typename T, std::size_t N>
constexpr std::size_t arraySize(T (&)[N]) noexcept
{
  return N;
}

/**
 * Use of a template function allowing a range for loop to be used on an
 * array of values.
 *
 * @param   vals  C array of integers
 */
template <std::size_t array_size>
void print_int_array(int (&vals)[array_size]) {
  for (int it : vals) {
    std::cout << it << "  ";
  }
}

