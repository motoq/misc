#include <iostream>

/**
 * Demonstrates creating "range for" compatible containers.
 */

/**
 * Simple class with .begin() and .end() functions to demonstrate use in
 * a range for loop.  Data is stored in a C array.
 */
class V {
public:
  V()
  {
    for (int ii=0; ii<nv; ++ii) {
      v[ii] = ii;
    }
  }

  /** @return the address of the first element in the "container" */
  int* begin()
  {
    return &v[0];
  }

  /**
   * @return  Returns the past-the-end element address in the list.
   * It is not a valid element itself.  It should not be dereferenced.
   */
  int* end()
  {
      // &v[nv] is equivalent to &*(v + nv), which is supposed to omit
      // both the '&' and the '*' upon evaluation.  So we are not
      // dereferencing past the end of the array and taking the address
      // of that potentially undefined behavoir.  In other words, &v[nv]
      // is legal and does not dereference the element. But, for real
      // code, it might make more sense to define v as,
      //   int v[nv+1];
      // just in case some compiler wasn't compliant with the standard.
    return &v[nv];
  }

private:
  constexpr static int nv = 10;
  int v[nv];
};

/** Plain old data to be returned by Resource container */
struct POD {
  double start {0.0};
  double stop {0.0};
};

/**
 * Example of a class that was supposed to keep outputing POD data
 * until some resource ran out.  However, the range-for loop increments
 * a pointer initially set to the first element and stops once the last
 * is hit.  It isn't meant for retrieval of dynamic data.
 */
class Resource {
public:
  POD* begin()
  {
    return &first;
  }

  /**
   * @return  Last "element" serves as a marker.
   */
  POD* end()
  {
    return &last;
  }

private:
    // Only stops on last if memory is contiguous
  POD first {1, 1};                    // Memory address used to start loop
  POD middle {2, 2};                   // Shady...
  double stuff1 {-1.};                 //  ...
  double stuff2 {-2.};                 //  ...
  //double stuff3 {-3.};               // Breaks things - stop address skipped
  POD last {3,3};                      // Memory address used to stop loop
};

/**
 * The range for loop takes the address of the first element and
 * increments it until it reaches the address past the last element.
 */
int main()
{

    // Start with a standard C array.
  std::cout << "\nOutput a standard C array\n";
  int a[] = {1, 2, 3};
  for (auto it : a) {
    std::cout << it << "  ";
  }
  std::cout << '\n';

  V v;
    // auto returns a copy
  std::cout << "\nModify a copy of container value:  before  after\n";
  for (auto it : v) {
    std::cout << it << "    ";
    it *= 2;;
    std::cout << it << '\n';
  }
  std::cout << '\n';
  std::cout << "\nNote first value is the original.  Now modify reference\n";
    // auto& returns a reference - allows for modification
    // of the original array of data
  for (auto& it : v) {
    std::cout << it << "    ";
    it *= 2;;
    std::cout << it << '\n';
  }
  std::cout << '\n';
  std::cout << "\nNote modification from previous loop remains in effect\n";
    // Return a reference, but disallow modification
  for (const auto& it : v) {
    std::cout << it << '\n';
    //it *= 2;;
    //std::cout << it << '\n';
  }
  std::cout << '\n';

    // Not meant for real code, but illustrates what is happening.
  Resource r;
  for (auto it : r) {
    std::cout << it.start << "    " << it.stop << '\n';
  }

  std::cout << '\n';

}
