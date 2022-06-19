#include <iostream>
#include <string>
#include <stdexcept>

#include <mth_permutation.h>
#include <mth_permutation_x.h>

/**
 * Prints permutations of the input integers along with indicating if
 * even (positive) or odd (negative).
 *
 */
int main(int argc, char *argv[]) {

  int n {0};
  for (int iarg=1; iarg<argc; ++iarg) {
    try {
      n = std::stoi(argv[iarg]);
    } catch(std::invalid_argument const& ia) {
      std::cerr << "\ninvalid_argument: " << argv[iarg];
      continue;
    } catch(std::out_of_range const& oor) {
      std::cerr << "out_of_range: " << argv[iarg];
      continue;
    }

    std::cout << "\n\n--- Dynamic input permutations ---";
    PermutationX permsX(n);
    std::cout << "\nPermutations of: " << n;
    for (int ii=0; ii<permsX.getNumberOfPermutations(); ++ii) {
      std::cout << "\n";
      for (int jj=0; jj<n; ++jj) {
        std::cout << " " << permsX(ii,jj);
      }
      std::cout << "  " << ((permsX(ii) == 1) ? "even" : "odd");
    }
  }

  std::cout << "\n\n--- Static input permutations ---";
  Permutation<4> perms;
  PermutationX permsX(perms.getDimension());
  std::cout << "\n\nPermutations of: " << perms.getDimension();
  for (int ii=0; ii<perms.getNumberOfPermutations(); ++ii) {
    std::cout << "\n";
    for (int jj=0; jj<n; ++jj) {
      std::cout << " " << perms(ii,jj);
    }
    std::cout << "  " << ((perms(ii) == 1) ? "even" : "odd ");
    std::cout << "  vs. X  ";
    for (int jj=0; jj<n; ++jj) {
      std::cout << " " << permsX(ii,jj);
    }
    std::cout << "  " << ((permsX(ii) == 1) ? "even" : "odd");
  }
  
  
  std::cout << '\n';
}
