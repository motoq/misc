#include <iostream>
#include <cmath>

#define EIGEN_NO_MALLOC
#include <Eigen/Dense>
#include <Eigen/Geometry>

/**
 * Demonstrates reference frame transformation (vs. vector rotations)
 * using Eigen matrix and quaternion classes.
 */
int main()
{
  using namespace std;
  using namespace Eigen;

    // Ground truth RPY matrix reference frame transformation matrix
  Matrix3d m_gt;
  m_gt <<  0.35355,  0.61237, -0.70711,
          -0.49282,  0.76445,  0.41563,
           0.79507,  0.20153,  0.57206;

    // Must use negative angle for reference frame transformation
  Matrix3d rmat {AngleAxisd(-M_PI/5.0, Vector3d::UnitX())};
  Matrix3d pmat {AngleAxisd(-M_PI/4.0, Vector3d::UnitY())};
  Matrix3d ymat {AngleAxisd(-M_PI/3.0, Vector3d::UnitZ())};
  Quaterniond rquat {AngleAxisd(-M_PI/5.0, Vector3d::UnitX())};
  Quaterniond pquat {AngleAxisd(-M_PI/4.0, Vector3d::UnitY())};
  Quaterniond yquat {AngleAxisd(-M_PI/3.0, Vector3d::UnitZ())};

    // Combined rotation sequence - standard matrix order of operation
    // Roll, then pitch, then yaw
  const Matrix3d m {rmat*pmat*ymat};
  const Quaterniond q {rquat*pquat*yquat};

    // Test vector
  const Vector3d x {1.0, 1.0, 1.0};
  const Vector3d mx {m*x};
  const Vector3d qx {q*x};
  const Vector3d dx {mx - qx};

  std::cout << "\n\nExpected m:\n";
  std::cout << m_gt;
  std::cout << "\nComputed m:\n";
  std::cout << m;
  std::cout << "\nmx:\n";
  std::cout << m*x;
  std::cout << "\nqx:\n";
  std::cout << q*x;
  std::cout << "\nDelta: " << dx.norm();

  cout << '\n';
}

