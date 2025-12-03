#include <iostream>
#include <cmath>
#include <numbers>

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

    // Aerospace sequence is Yaw   about the z-axis,
    //                       Pitch about the y-axis, and
    //                       Roll  about the z-axis
  constexpr double ax {numbers::pi/5.0};    // Roll
  constexpr double ay {numbers::pi/4.0};    // Pitch
  constexpr double az {numbers::pi/3.0};    // Yaw

    // Externally generated ground truth RPY matrix
    // reference frame transformation matrix
  Matrix3d m_gt;
  m_gt <<  0.35355,  0.61237, -0.70711,
          -0.49282,  0.76445,  0.41563,
           0.79507,  0.20153,  0.57206;

    // Create reference frame transformation matrices manually.
  Matrix3d rmat;
  Matrix3d pmat;
  Matrix3d ymat;
  rmat << 1.0,      0.0,     0.0,
          0.0,  cos(ax), sin(ax),
          0.0, -sin(ax), cos(ax);
  pmat << cos(ay),  0.0,  -sin(ay),
              0.0,  1.0,       0.0,
          sin(ay),  0.0,   cos(ay);
  ymat <<  cos(az), sin(az), 0.0,
          -sin(az), cos(az), 0.0,
           0.0,         0.0, 1.0;
    // Create Quaternion
  Quaterniond rquat {AngleAxisd(ax, Vector3d::UnitX())};
  Quaterniond pquat {AngleAxisd(ay, Vector3d::UnitY())};
  Quaterniond yquat {AngleAxisd(az, Vector3d::UnitZ())};

    // Yaw, then pitch, then roll
    //
    // For the matrix library, multipley reference frame
    // transformations right to left
  const Matrix3d m {rmat*pmat*ymat};
    // For quaternion rotation sequences, multiply left to right,
    // then take the inverse, to get the equivalent reference frame
    // transformation.
  const Quaterniond q {(yquat*pquat*rquat).conjugate()};

    // Test vector
  const Vector3d x {1.0, 1.0, 1.0};
  const Vector3d mx {m*x};
  const Vector3d qx {q*x};
  const Vector3d dx {mx - qx};

  cout << "\n\nExpected m:\n";
  cout << m_gt;
  cout << "\nComputed m:\n";
  cout << m;
  cout << "\nmx:\n";
  cout << mx;
  cout << "\nqx:\n";
  cout << qx;
  cout << "\nDelta: " << dx.norm();

  cout << '\n';
}

