#include <iostream>

// arraySize
#include <cstddef>

// toUType
#include <type_traits>

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


/**
 * The toUType utility function from "Effective Modern C++ by Scott Meyers
 * (O'Reilly).  Copyright 2015 Scott Meyers, 978-1-491-90399-5."
 *
 * A C++14 compatible compile time evaluation of a class enum component
 * to its underlying type.  Useful for providing array or container
 * indexing by name vs. hard coded numbers while avoiding namespace
 * pollution that comes with traditional unscoped enums.
 *
 * @return  An enum component (enumerator) value by the underlying enumeration
 * type.
 */
template<typename E>
constexpr auto endx(E enumerator) noexcept
{
  return static_cast<std::underlying_type_t<E>>(enumerator);
}


/**
 * The toUType utility function from "Effective Modern C++ by Scott Meyers
 * (O'Reilly).  Copyright 2015 Scott Meyers, 978-1-491-90399-5."
 *
 * A C++11 compatible compile time evaluation of a class enum component
 * to its underlying type.  Useful for providing array or container
 * indexing by name vs. hard coded numbers while avoiding namespace
 * pollution that comes with traditional unscoped enums.
 *
 * @return  An enum component (enumerator) value by the underlying enumeration
 * type.
 */
template<typename E>
constexpr typename std::underlying_type<E>::type
   endx_(E enumerator) noexcept
{
  return static_cast<typename
                     std::underlying_type<E>::type>(enumerator);
}

