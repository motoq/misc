#include <iostream>

#include <vector>
#include <execution>

#include <ishoot.h>
#include <m14.h>
#include <m14e2.h>

/**
 * Demonstrates the use of parallel processing via std::transform.  A
 * vector of configuration settings is accessed in parallel with a
 * vector of pointers.  Memory is allocated to each pointer based on the
 * corresponding configuration setting.
 */
int main() {

    // Firearm configuration, 1 for M14, 2 for M14E2
  std::vector<int> configs{ 1, 2, 1, 1, 2, 1, 1 };
    // Set target vector of pointers to matching size
    // so existing elements can be accessed in parallel
  std::vector<std::unique_ptr<IShoot>> guns(configs.size());

    // Parallel transform, over all configs elements, allocating object to
    // corresponding pointer element in guns.
  std::transform(std::execution::par,
                 configs.begin(), configs.end(), guns.begin(),
                 [](int cfg) {
                   std::unique_ptr<IShoot> m14;
                   if (cfg == 2) {
                     m14 = std::make_unique<M14E2>("Config 2");
                   } else {
                     m14 = std::make_unique<M14>("Config 1");
                   }
                     // Set element in guns corresponding to cfg
                   return m14;
                 }
  );


    // Test list of guns
  for (const auto& gun : guns) {
    gun->fire();
  }

  std::cout << '\n';
}
