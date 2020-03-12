#include <iostream>
#include <string>
#include <tuple>

#include <utl_smeyers.h>

/**
 * Demonstrates a handful of useful utility functions from Scott Meyers
 * "Effective Modern C++".
 *
 * @author  Kurt Motekew
 */
int main()
{

  /*
   * The arraySize() template function can determine the size of a
   * standard C++ array at compile time.  Note the array itself does not
   * need to be constexpr.  How cool is that...
   */
  std::cout << "\n*\n* Demonstrating compile time array size evaluation\n*\n";
  constexpr double coeffs[] = { 1., 2., 3., 4., 5., 6., 7., 8., 9. };
  constexpr int ncoeff = arraySize(coeffs);
  std::cout << "\nDouble array size is " << ncoeff << " - very cool!";
    // Not constexpr
  std::string colors[] = { "Red", "Green", "Blue" }; 
  int ncolors = arraySize(colors);
  std::cout << "\nNumber of colors is " << ncolors;
  std::cout << '\n';

    // Start with a standard C array.
  std::cout << "\nOutput a standard C array\n";
  int a[] = {1, 2, 3};
  for (auto it : a) {
    std::cout << it << "  ";
  }
  std::cout << '\n';
    // Can't send to a standard function as a pointer,
    // but can use a template function
  std::cout << "\nOutput a standard C array via template function\n";
  print_int_array(a);
  std::cout << '\n';



  std::cout << "\n\n*\n* Demonstrating compile time enum class indexing\n*\n";
  enum Ndx { first, second }; 
  enum class NdxC { first, second }; 
  auto tvals = std::tuple<int, int>{-1, 1};

  std::cout << "\nIndexing a Tuple with an enum";
  std::cout << "\n\tFirst: " << std::get<first>(tvals);
  std::cout << "    Second: " << std::get<second>(tvals);
  
  std::cout << "\nIndexing a Tuple with an enum class C++14 style";
  std::cout << "\n\tFirst: " << std::get<endx(NdxC::first)>(tvals);
  std::cout << "    Second: " << std::get<endx(NdxC::second)>(tvals);
  
  std::cout << "\nIndexing a Tuple with an enum class C++11 style";
  std::cout << "\n\tFirst: " << std::get<endx_(NdxC::first)>(tvals);
  std::cout << "    Second: " << std::get<endx_(NdxC::second)>(tvals);
  

  std::cout << '\n';
}





