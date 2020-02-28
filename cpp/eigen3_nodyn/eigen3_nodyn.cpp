
#include <iostream>

#define EIGEN_NO_MALLOC
#include <eigen3/Eigen/Core>
    
using namespace std;
using namespace Eigen;

constexpr int n {3};
    
void init(Matrix<double,n,n>& a, Matrix<double,n,n>& b, Matrix<double,n,n>& c)
{
  a.setOnes();
  b.setOnes();
  c = 0.00001*Matrix<double,n,n>::Ones();
}
    
void update(Matrix<double,n,n>& a, Matrix<double,n,n>& b, Matrix<double,n,n>& c)
{
  // Pretty random equations to illustrate dynamic memory allocation
  b += c;
  a += b*c;
  c += b*c;
}
    
int main()
{
      
    // Initialization (not real-time)
  Matrix<double,n,n> a;
  Matrix<double,n,n> b;
  Matrix<double,n,n> c;
  init(a,b,c);
    
  // Real-time loop
  for (float t=0.0; t<0.1; t+=0.01)
    update(a,b,c);
      
  return 0;
}
