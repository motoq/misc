#include <iostream>
#include <cstring>

#include <utl_bytes.h>

/**
 * Driver program to demonstrate use of template function that converts
 * between big and little endian.
 *
 * Arguments will be converted to doubles and integers, printed,
 * swapped, and printed again.  The test for integers only swaps the
 * bytes if the host system is little endian.  On a big endian system,
 * the integer test should result in different answers for before vs.
 * after.
 */
int main(int argc, char *argv[]) {
  // Program assumes double fits in a long long and
  // a long long fits in a double
  static_assert(sizeof(double) == sizeof(long long),
                "size of long long must equal size of double");

    // Print sizes even if no arguments are supplied
  std::cout << "\nshort:      " << sizeof(short);
  std::cout << "\nint:        " << sizeof(int);
  std::cout << "\nlong:       " << sizeof(long);
  std::cout << "\nlong long:  " << sizeof(long long);
  std::cout << "\nfloat:      " << sizeof(float);
  std::cout << "\ndouble:     " << sizeof(double);

    // Try to convert each argument to a double and an integer, then
    // test swapping functions.
  if (argc > 1) {
    for (int ii=1; ii<argc; ++ii) {
      double x1 = atof(argv[ii]);
      int y1 = atoi(argv[ii]);

        // For the double test, swap unconditionally
      std::cout << "\n\nTest double";
      long long data;
      std::memcpy(&data, &x1, sizeof data);
      data = swap_bytes<long long>(data);
      data = swap_bytes<long long>(data);
      double x2;
      std::memcpy(&x2, &data, sizeof x2);
      std::cout << "\nx1: " << x1;
      std::cout << "\nx2: " << x2;
      std::cout << "\ndx: " << x2 - x1;

        // Only do the integer swap if on a little endian system
      std::cout << "\n\nTest int";
      auto tmp = moa_hton(y1);
      auto y2 = swap_bytes(tmp);
      std::cout << "\n(swapped):" << tmp;
      std::cout << "\ny1: " << y1;
      std::cout << "\ny2: " << y2;
      std::cout << "\ndy: " << y2 - y1;
    }
  }
  
  std::cout << '\n';
}
