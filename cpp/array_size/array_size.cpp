#include <iostream>
#include <string>

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
  constexpr double coeffs[] = { 1., 2., 3., 4., 5., 6., 7., 8., 9. };
  constexpr int ncoeff = arraySize(coeffs);
  std::cout << "\nDouble array size is " << ncoeff << " - very cool!";
    // Not constexpr
  std::string colors[] = { "Red", "Green", "Blue" }; 
  int ncolors = arraySize(colors);
  std::cout << "\nNumber of colors is " << ncolors;

  std::cout << '\n';
  
}

