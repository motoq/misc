#include <cstddef>

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
