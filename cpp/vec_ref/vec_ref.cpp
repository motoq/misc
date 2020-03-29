#include <iostream>
#include <vector>

/**
 * Demonstrates how parameters in a vector can be returned by reference.
 */
int main()
{
  std::vector<int> ivals {1, 2, 3, 4};
  std::cout << "\nOriginal x1 in vector:\t" << ivals[1];

  std::cout << "\nPull x1 by copy and change value";
  int x = ivals[1];
  x = 3;
  std::cout << "\nx1 set to 3:\t" << x;
  std::cout << "\nx1 in vector:\t" << ivals[1];

  std::cout << "\nPull x1 by reference and change value";
  int& xref = ivals[1];
  xref = 3;
  std::cout << "\nx1 set to 3:\t" << xref;
  std::cout << "\nx1 in vector:\t" << ivals[1];

  std::cout << '\n';

}
