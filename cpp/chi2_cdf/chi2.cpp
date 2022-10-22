#include <iostream>
#include <string>
#include <stdexcept>
#include <numbers>
#include <cmath>


constexpr double chi2_cdf_1d(double k)
{
  return std::erf(k/std::numbers::sqrt2);
}

constexpr double chi2_cdf_2d(double k)
{
  return 1.0 - std::exp(-0.5*k*k);
}

constexpr double chi2_cdf_3d(double k)
{
  return chi2_cdf_1d(k) -
         k*std::numbers::sqrt2*std::numbers::inv_sqrtpi*std::exp(-0.5*k*k);
}

/**
 *
 */
int main(int argc, char *argv[]) {

  if (argc != 3) {
    std::cerr << "\nProper use is: " << argv[0] << " dim n-stddev\n";
    return 0;
  }

  int dim {};
  double kappa {};
  try {
    dim = std::stoi(argv[1]);
    kappa = std::stof(argv[2]);
  } catch(std::invalid_argument const& ia) {
    std::cerr << "\ninvalid_argument\n";
    return 0;
  } catch(std::out_of_range const& oor) {
    std::cerr << "out_of_range: dimension\n";
    return 0;
  }
    
  //constexpr double pi {std::numbers::pi};
  
  switch (dim) {
    case 1:
      std::cout << '\n' << chi2_cdf_1d(kappa);
      break;
    case 2:
      std::cout << '\n' << chi2_cdf_2d(kappa);
      break;
    case 3:
      std::cout << '\n' << chi2_cdf_3d(kappa);
      break;
    default:
      std::cout << "\nDimensions 1-3 supported vs.: " << dim << '\n';
  }

  std::cout << '\n';
}
