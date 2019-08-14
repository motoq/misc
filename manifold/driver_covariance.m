% Illustrates mapping 2D covariance matrices in 3D space.  Two ellipses
% are projected to a sphere given their relative orientations and a
% location on the sphere.
% 
% o  3D Cartesian origin
% p  Reference point on sphere
% y1 1st ellipse/covariance location
% y2 2nd ellipse/covariance location
%
% c  3D Cartesian reference frame
% y  1st or second ellipse reference frame
% t  2D reference plane tangent to sphere at reference point
%      z points towards the origin
%      x points "east"
%      y points "south"
%
% Relies on the Bierman sequential estimation project - add to path
% 
% Kurt Motekew  2014/10/19  Original
% Kurt Motekew  2019/08/10  Updated to be more generic and added with
%                           unscented transform version
%

clear;
close all;

  % Sphere - place at origin
re = 1.0;
SphereModel = [ re*re    0      0 ;
                  0    re*re    0 ;
                  0      0    re*re ; ];

  % Define 2D ellipses via covariance matrices
  % In 3D, axes are y1, y2, y3.
sf = 1.0;
dy1  = sind(sf*3);
dy2  = sind(sf*1);
SigmaY = [ dy1*dy1    0   ;
              0    dy2*dy2  ];
W = SigmaY^-1;
nobs = size(SigmaY,1);

  % Plotting - extend to a 3x3 matrix
SigmaYModel = zeros(3);
SigmaYModel(1:nobs,1:nobs) = SigmaY;

  % Place reference point (rp) on sphere using spherical coordinates
theta = 45*pi/180;
phi = 30*pi/180;
  % Location of reference point (rp) relative to origin (o) in the 3D
  % Cartesian reference frame (c)
r_p_o_c = mth_sphere2cart(re, theta, phi);
  % Transformation from t to c reference frame.
  % dcart/dsphere places x-axis pointing radially out so a y-axis
  % rotation of 90 deg is required to meet the above definition of the t
  % (tangent) frame.
  %                   dcart/dsphere_ll * dsphere_ll/t
  %                            Tc_ll*Tll_t
Tct = mth_dcart_dsphere(re, theta, phi)*mth_roty(-pi/2);
Ttc = Tct';

  % Place ellipses in y-z plane.  Rotate each ellipse such that y3
  % points towards the center of the sphere.  Position and orientation:
r_y1_o_c = re*[ 0 1.5 cosd(30) ]';
Tyc1 = mth_rotx(120*pi/180);
Tcy1 = Tyc1';
  % Ellipse to reference point vector and unit vector
r_p_y1_c = r_p_o_c - r_y1_o_c;
invrmag = 1/norm(r_p_y1_c);
rhat_p_y1_c = invrmag*r_p_y1_c;
  % Partials pointing to reference point location
Ap1 = Tyc1(1:2,:)*invrmag*(eye(3) - rhat_p_y1_c*rhat_p_y1_c')*Tct(:,1:2);
ApTWAp1 = Ap1'*W*Ap1;
SigmaP1 = ApTWAp1^-1;

  % Second Y ellipse
r_y2_o_c = re*[ 0 cosd(30) 1.5 ]';
Tyc2 = mth_rotx(150*pi/180);
Tcy2 = Tyc2';
  % Ellipse to reference point vector and unit vector
r_p_y2_c = r_p_o_c - r_y2_o_c;
invrmag = 1/norm(r_p_y2_c);
rhat_p_y2_c = invrmag*r_p_y2_c;
  % Partials pointing to reference point location
Ap2 = Tyc2(1:2,:)*invrmag*(eye(3) - rhat_p_y2_c*rhat_p_y2_c')*Tct(:,1:2);
ApTWAp2 = Ap2'*W*Ap2;
SigmaP2 = ApTWAp2^-1;



  % Plot Sphere
figure; hold on;
matrix3X3_plot(SphereModel, 40, true);
  % Plot 1st Y ellipse.  Rotate so use y to c transformation
SigmaYModel_c = Tcy1*SigmaYModel*Tcy1';
[XX, YY, ZZ] = matrix3X3_points(SigmaYModel_c, 40);
surf(XX + r_y1_o_c(1), YY + r_y1_o_c(2), ZZ + r_y1_o_c(3));
  % Plot 1st P ellipse.
SigmaP1Model = zeros(3);
SigmaP1Model(1:nobs,1:nobs) = SigmaP1;
SigmaP1Model_c = Tct*SigmaP1Model*Tct';
[XX, YY, ZZ] = matrix3X3_points(SigmaP1Model_c, 40);
surf(XX + r_p_o_c(1), YY + r_p_o_c(2), ZZ + r_p_o_c(3));
  % Plot 2nd Y and P ellipses.
SigmaYModel_c = Tcy2*SigmaYModel*Tcy2';
[XX, YY, ZZ] = matrix3X3_points(SigmaYModel_c, 40);
surf(XX + r_y2_o_c(1,1), YY + r_y2_o_c(2,1), ZZ + r_y2_o_c(3,1));
SigmaP2Model = zeros(3);
SigmaP2Model(1:nobs,1:nobs) = SigmaP2;
SigmaP2Model_c = Tct*SigmaP2Model*Tct';
[XX, YY, ZZ] = matrix3X3_points(SigmaP2Model_c, 40);
surf(XX + r_p_o_c(1), YY + r_p_o_c(2), ZZ + r_p_o_c(3));
  %...
xlabel('x');
ylabel('y');
zlabel('z');
title('Covariance Mapping via Partials');

  % Combined covariance
AptWAp12 = ApTWAp1 + ApTWAp2;
SigmaP12 = AptWAp12^-1;
  % Plot comparison on new figure
figure; hold on;
SigmaP1Model = zeros(3);
SigmaP1Model(1:nobs,1:nobs) = SigmaP1;
[XX, YY, ZZ] = matrix3X3_points(SigmaP1Model, 40);
mesh(XX, YY, ZZ);
SigmaP2Model = zeros(3);
SigmaP2Model(1:nobs,1:nobs) = SigmaP2;
[XX, YY, ZZ] = matrix3X3_points(SigmaP2Model, 40);
mesh(XX, YY, ZZ);
SigmaP12Model = zeros(3);
SigmaP12Model(1:nobs,1:nobs) = SigmaP12;
[XX, YY, ZZ] = matrix3X3_points(SigmaP12Model, 40);
surf(XX, YY, ZZ);
xlabel('x');
ylabel('y');
zlabel('z');
title('Combined Covariance Mapping via Partials');
axis equal;


 % Unscented Transform Version

alpha = .01;
kappa = 0;
beta = 2;
[Chi, w_m, w_c] = est_ut_sigma_vec([0 0]', SigmaY, alpha, kappa, beta);
n_obs = size(Chi,1);
n_sigma_vec = size(Chi, 2);
  % First transformation
r_p_y1_c = r_p_o_c - r_y1_o_c;
r_p_y1_y = Tyc1*r_p_y1_c;
rhat_p_y1_y = r_p_y1_y/norm(r_p_y1_y);
Chi1 = zeros(n_obs, n_sigma_vec);
for ii = 1:n_sigma_vec
  u = rhat_p_y1_y(1) + Chi(1,ii);
  v = rhat_p_y1_y(2) + Chi(2,ii);
  w = sqrt(1 - u*u - v*v);
  rhat_p_y1_y_i = [u v w]';
  rhat_p_y1_c_i = Tcy1*rhat_p_y1_y_i;
  r_p_o_c_i = mth_xsphere(r_y1_o_c, rhat_p_y1_c_i, re);
  r_p_y1_c = r_p_o_c_i - r_p_o_c;
  r_p_y1_t = Ttc*r_p_y1_c;
  Chi1(:,ii) = r_p_y1_t(1:2);
end
[~, SigmaP1] = est_pred_ukf(Chi1, w_m, w_c, zeros(n_obs));
  % Second transformation
r_p_y2_c = r_p_o_c - r_y2_o_c;
r_p_y2_y = Tyc2*r_p_y2_c;
rhat_p_y2_y = r_p_y2_y/norm(r_p_y2_y);
Chi2 = zeros(n_obs, n_sigma_vec);
for ii = 1:n_sigma_vec
  u = rhat_p_y2_y(1) + Chi(1,ii);
  v = rhat_p_y2_y(2) + Chi(2,ii);
  w = sqrt(1 - u*u - v*v);
  rhat_p_y2_y_i = [u v w]';
  rhat_p_y2_c_i = Tcy2*rhat_p_y2_y_i;
  r_p_o_c_i = mth_xsphere(r_y2_o_c, rhat_p_y2_c_i, re);
  r_p_y2_c = r_p_o_c_i - r_p_o_c;
  r_p_y2_t = Ttc*r_p_y2_c;
  Chi2(:,ii) = r_p_y2_t(1:2);
end
[~, SigmaP2] = est_pred_ukf(Chi2, w_m, w_c, zeros(n_obs));

  % Plot Sphere
figure; hold on;
matrix3X3_plot(SphereModel, 40, true);
  % Plot 1st Y ellipse.  Rotate so use y to c transformation
[XX, YY, ZZ] = matrix3X3_points(SigmaYModel_c, 40);
surf(XX + r_y1_o_c(1), YY + r_y1_o_c(2), ZZ + r_y1_o_c(3));
  % Plot 1st P ellipse.
SigmaP1Model = zeros(3);
SigmaP1Model(1:nobs,1:nobs) = SigmaP1;
SigmaP1Model_c = Tct*SigmaP1Model*Tct';
[XX, YY, ZZ] = matrix3X3_points(SigmaP1Model_c, 40);
surf(XX + r_p_o_c(1), YY + r_p_o_c(2), ZZ + r_p_o_c(3));
  % Plot 2nd Y and P ellipses.
[XX, YY, ZZ] = matrix3X3_points(SigmaYModel_c, 40);
surf(XX + r_y2_o_c(1,1), YY + r_y2_o_c(2,1), ZZ + r_y2_o_c(3,1));
SigmaP2Model = zeros(3);
SigmaP2Model(1:nobs,1:nobs) = SigmaP2;
SigmaP2Model_c = Tct*SigmaP2Model*Tct';
[XX, YY, ZZ] = matrix3X3_points(SigmaP2Model_c, 40);
surf(XX + r_p_o_c(1), YY + r_p_o_c(2), ZZ + r_p_o_c(3));
  %...
xlabel('x');
ylabel('y');
zlabel('z');
title('Covariance Mapping via UT');

  % Plot comparison on new figure
figure; hold on;
SigmaP1Model = zeros(3);
SigmaP1Model(1:nobs,1:nobs) = SigmaP1;
[XX, YY, ZZ] = matrix3X3_points(SigmaP1Model, 40);
mesh(XX, YY, ZZ);
SigmaP2Model = zeros(3);
SigmaP2Model(1:nobs,1:nobs) = SigmaP2;
[XX, YY, ZZ] = matrix3X3_points(SigmaP2Model, 40);
mesh(XX, YY, ZZ);
%SigmaP12Model = zeros(3);
%SigmaP12Model(1:nobs,1:nobs) = SigmaP12;
%[XX, YY, ZZ] = matrix3X3_points(SigmaP12Model, 40);
%surf(XX, YY, ZZ);
xlabel('x');
ylabel('y');
zlabel('z');
title('Combined Covariance Mapping via UT');
axis equal;
