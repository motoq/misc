#include <iostream>
#include <string>
#include <stdexcept>
#include <numbers>
#include <cmath>


/**
 * Compute the probability a variable from the 1D Chi^2 distribution
 * is within k standard deviations.
 *
 * @param  k  Number of standard deviations
 *
 * @return  Probability for 1 degree of freedom
 */
constexpr double chi2_cdf_1d(double k)
{
  return std::erf(k/std::numbers::sqrt2);
}

/**
 * Compute the probability a 2D variable from the Chi^2 distribution
 * is within k standard deviations.
 *
 * @param  k  Number of standard deviations
 *
 * @return  Probability for 2 degrees of freedom
 */
constexpr double chi2_cdf_2d(double k)
{
  return 1.0 - std::exp(-0.5*k*k);
}

/**
 * Compute the probability a 3D variable from the Chi^2 distribution
 * is within k standard deviations.
 *
 * @param  k  Number of standard deviations
 *
 * @return  Probability for 3 degrees of freedom
 */
constexpr double chi2_cdf_3d(double k)
{
  return chi2_cdf_1d(k) -
         k*std::numbers::sqrt2*std::numbers::inv_sqrtpi*std::exp(-0.5*k*k);
}

/**
 * Tests computing Chi^2 probability of containment.
 *
 * Kurt Motekew  2022/10/22
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
    
  double p {0.0};
  switch (dim) {
    case 1:
      p = chi2_cdf_1d(kappa);
      break;
    case 2:
      p = chi2_cdf_2d(kappa);
      break;
    case 3:
      p =  chi2_cdf_3d(kappa);
      break;
    default:
      std::cout << "\nDimensions 1-3 supported vs.: " << dim << '\n';
      return 0;
  }

  std::cout << "\nProbability that " << kappa <<
               " is within " << dim << "D Chi^2:  " << p;
  std::cout.precision(7);
  std::cout << "\nProbability that " << kappa <<
               " is outside " << dim << "D Chi^2: " << 1.0 - p;

  std::cout << '\n';
}
