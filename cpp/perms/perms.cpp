#include <iostream>
#include <string>
#include <stdexcept>
#include <vector>
#include <algorithm>

/**
 * Computes permutations of the input integers along with indicating if
 * even (positive) or odd (negative).
 *
 */
int main(int argc, char *argv[]) {

  int n {0};
  for (int ii=1; ii<argc; ++ii) {
    try {
      n = std::stoi(argv[ii]);
    } catch(std::invalid_argument const& ia) {
      std::cerr << "\ninvalid_argument: " << argv[ii];
      continue;
    } catch(std::out_of_range const& oor) {
      std::cerr << "out_of_range: " << argv[ii];
      continue;
    }

    std::vector<int> elements;
    for (int ii=1; ii<=n; ++ii) {
      elements.push_back(ii);
    }

    std::cout << "\nPermutations of: " << n;
    do {
      std::cout << '\n';
      for (auto perm : elements) {
        std::cout << perm << " ";
      }
    } while (std::next_permutation(elements.begin(), elements.end()));



  }
  
  std::cout << '\n';
}
