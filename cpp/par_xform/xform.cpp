#include <iostream>

#include <string>
#include <vector>
#include <unordered_map>
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
  std::vector<std::string> configs{ "M14",
                                    "M14E2",
                                    "M14",
                                    "M14",
                                    "M14E2",
                                    "M14",
                                    "M14" };
    // Set target vector of pointers to matching size
    // so existing elements can be accessed in parallel
  std::vector<std::unique_ptr<IShoot>> guns(configs.size());

    // Parallel transform, over all configs elements, allocating object to
    // corresponding pointer element in guns.
  std::transform(std::execution::par,
                 configs.begin(), configs.end(), guns.begin(),
                 [](const auto& cfg) {
                   std::unique_ptr<IShoot> m14;
                   if (cfg == "M14E2") {
                     m14 = std::make_unique<M14E2>(cfg);
                   } else {
                     m14 = std::make_unique<M14>(cfg);
                   }
                     // Set element in guns corresponding to cfg
                   return m14;
                 }
  );


    // Test list of guns
  std::cout << "\n\nTest vector\n";
  for (const auto& gun : guns) {
    gun->fire();
  }

    // Test move of elements to map
  std::cout << "\n\nTest move to map\n";
  std::unordered_map<std::string, std::unique_ptr<IShoot>> guns_map;
  for (unsigned int ii=0; ii<configs.size(); ++ii) {
    std::string id = configs[ii] + std::to_string(ii);
    guns_map[id] = std::move(guns[ii]);
  }
  for (const auto& gun : guns_map) {
    gun.second->fire();
  }

  std::cout << '\n';
}
