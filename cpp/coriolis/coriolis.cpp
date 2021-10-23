#include <cmath>
#include <iostream>

#define EIGEN_NO_MALLOC
#include <Eigen/Dense>
#include <Eigen/Geometry>

/**
 * Demonstrates accounting for Coriolis when converting inertial
 * velocity and acceleration to earth fixed.  The first method
 * directly uses the first and second derivative of the ECI to ECF
 * transformation matrix (apply chain rule to r_f = C*r_i).  Note
 * that position and velocity vectors on the rhs of the equation are
 * all ECI.  The second method uses the more traditional approach
 * where the transformations are rewritten in terms of cross products
 * involving ECF position and velocity vectors on the RHS.
 */
int main()
{
  using namespace std;
  using namespace Eigen;

    // Environment
  constexpr double gm {398600.4415};                  // km^3/sec^2
  constexpr double w {7.292115e-5};                   // rad/sec
  const Vector3d w_vec(0.0, 0.0, w);
  
    // Input time, position, velocity (seconds, km, km/sec)
  constexpr double t {3600.0};
  const Vector3d r_i(-5551.89830588,-2563.04968199,3257.75675542);
  const Vector3d v_i(2.149073080,-7.539456520,-2.185708850);
    // Compute gravitational acceleration
  const double r {r_i.norm()};
  const double r3 {r*r*r};
  const Vector3d a_i {-gm*r_i/r3};

    // ECI to ECF reference frame transformation
  constexpr double wt {w*t};
  Matrix3d c;
  c <<  cos(wt), sin(wt), 0.0,                        // Note this form of init
       -sin(wt), cos(wt), 0.0,                        // can suffer from runtime
            0.0,     0.0, 1.0;                        // error
    // First time derivative
  Matrix3d cdot;
  cdot << -w*sin(wt),  w*cos(wt), 0.0,
          -w*cos(wt), -w*sin(wt), 0.0,
                 0.0,        0.0, 0.0;
    // Second derivative
  constexpr double w2 {w*w};
  Matrix3d cddot;
  cddot << -w2*cos(wt),  -w2*sin(wt), 0.0,
            w2*sin(wt),  -w2*cos(wt), 0.0,
                   0.0,          0.0, 0.0;

    // Convert to ECF using only product rule
  const Vector3d r_f {c*r_i};
  const Vector3d v_f {c*v_i + cdot*r_i};
  const Vector3d a_f {c*a_i + 2*cdot*v_i + cddot*r_i};

    // Convert using traditional cross product method
  const Vector3d v_f_w {c*v_i - w_vec.cross(r_f)};
  const Vector3d a_f_w {c*a_i - 2*w_vec.cross(v_f_w)
                              - w_vec.cross(w_vec.cross(r_f))};

    // Difference
  const Vector3d dv {v_f - v_f_w};
  const Vector3d da {a_f - a_f_w};

  cout << "\nInertial Position:\n" << r_i;
  cout << "\nInertial Velocity:\n" << v_i;
  cout << "\nInertial Acceleration:\n" << a_i;
  cout << '\n';
  cout << "\nECI to ECF:\n" << c;
  cout << "\nd(ECI to ECF)/dt:\n" << cdot;
  cout << "\nd(ECI to ECF)/dtdt:\n" << cddot;
  cout << '\n';
  cout << "\nEarth Fixed Position:\n" << r_f;
  cout << "\nEarth Fixed Velocity:\n" << v_f;
  cout << "\nEarth Fixed Acceleration:\n" << a_f;
  cout << '\n';
  cout << "\nUsing Cross Products";
  cout << "\nEarth Fixed Velocity:\n" << v_f_w;
  cout << "\nEarth Fixed Acceleration:\n" << a_f_w;
  cout << '\n';
  cout << "\nVelocity Difference:      " <<  dv.norm() << "km/s";
  cout << "\nAcceleration Difference:  " <<  da.norm() << "km/s^2";

  cout << '\n';
}

