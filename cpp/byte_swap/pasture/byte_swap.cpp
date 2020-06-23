#include <cstddef>
#include <iostream>
#include <cstring>

constexpr bool is_big_endian() {
  return static_cast<bool>(0xff >> 8);
}

long long swap_bytes(long long);

int main() {

  static_assert(sizeof(double) == 8, "double must be 8 bytes");
  static_assert(sizeof(double) == sizeof(long long),
                "size of long must equal size of double");
  if (is_big_endian()) {
    std::cout << "\nBig endian system\n";
  } else {
    std::cout << "\nLittle endian system\n";
  }

  std::cout << "\nshort:      " << sizeof(short);
  std::cout << "\nint:        " << sizeof(int);
  std::cout << "\nlong:       " << sizeof(long);
  std::cout << "\nlong long:  " << sizeof(long long);
  std::cout << "\nfloat:      " << sizeof(float);
  std::cout << "\ndouble:     " << sizeof(double);


  double x1 = 52.0;
  long long data;
  std::memcpy(&data, &x1, sizeof data);

  data = swap_bytes(data);
  data = swap_bytes(data);

  double x2;
  std::memcpy(&x2, &data, sizeof x2);
  
  std::cout << "\nx1: " << x1;
  std::cout << "\nx2: " << x2;
  std::cout << "\ndx: " << x2 - x1;

  std::cout << '\n';
  
}

long long swap_bytes(long long val)
{
  constexpr size_t nbytes {sizeof(val)};
  char bytes[nbytes];
  std::memcpy(bytes, &val, nbytes);
  
  val = 0L;
  size_t nbits = static_cast<size_t>(8);
  size_t shift = nbits*(nbytes - static_cast<size_t>(1));
  for (size_t ii=0; ii<nbytes; ++ii) {
    val |= static_cast<long long>(0xff & bytes[ii]) << shift;
    shift -= nbits;
  }

  return val;
}

