/*
 * Copyright 2022 Kurt Motekew
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#include <mth_permutation.h>

#include <vector>
#include <algorithm>

Permutation::Permutation(int dim)
{
  n = dim;
    // create the set {1, 2,..., n}
  std::vector<int> elements;
  for (int ii=1; ii<=n; ++ii) {
    elements.push_back(ii);
  }

    // library creates perturbations - need to determine sign
  do {
      // Store current permutation, starting with 1:n
    e.push_back(elements);
      // Determine even (+1) vs. odd (-1) by seeing how many swaps
      // are needed to sort the current permutation
    std::vector<int> p = elements;
    int swaps {0};
    for (int elm=1; elm<=n; ++elm) {
      if (elm != p[elm-1]) {
        for (int ii=elm; ii<n; ++ii) {
          if (elm == p[ii]) {
            auto tmp = p[elm-1];
            p[elm-1] = p[ii];
            p[ii] = tmp;
            swaps++;
            break;
          }
        }
      }
    }
    s.push_back((swaps%2 == 0) ? 1 : -1);
  } while (std::next_permutation(elements.begin(), elements.end()));
}
