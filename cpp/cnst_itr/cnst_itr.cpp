#include <iostream>
#include <algorithm>
#include <vector>

//#include <utl_smeyers.h>

/**
 * Demonstrates use of an iterator with the find algorithm and what a
 * constant iterator brings.  Note the ability to increment an iterator
 * in the last example and the effect it has on insertion.
 *
 * @author  Kurt Motekew  2020/03/29
 */
int main()
{

  std::vector<int> values { 0, 1, 3, 4, 5, 6, 7 };

  for (auto it : values) {
    std::cout << "  " << it;
  }


  auto val = 2;
  std::cout << "\nCreating Iterator from find " << val << " and insert";
  const auto it = std::find(values.cbegin(), values.cend(), val);
  values.insert(it, val);
  std::cout << '\n';
  for (auto it : values) {
    std::cout << "  " << it;
  }

  auto fval = values[2];
  std::cout << "\nCreating Iterator from find " << fval << " and insert";
  const auto it2 = std::find(values.cbegin(), values.cend(), fval);
  values.insert(it2, val);
  std::cout << '\n';
  for (auto it : values) {
    std::cout << "  " << it;
  }

  fval = values[3];
  std::cout << "\nCreating Iterator from find " << fval << " and it++ insert";
  auto it3 = std::find(values.begin(), values.end(), fval);
    // Increment won't work for above "const auto" examples
  it3++;
  values.insert(it3, val);
  std::cout << '\n';
  for (auto it : values) {
    std::cout << "  " << it;
  }

  std::cout << '\n';

}

