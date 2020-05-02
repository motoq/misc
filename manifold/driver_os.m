% Plots an oblate spheroid along with basis vectors.  This version uses
% the ellipsoid semimajor axis as one of the OS coordinates.
%
% Kurt Motekew
% 2020/04
%

clear;

  % Define Oblate spheroid with fixed size
e = .9;                                          % Shape
a = 3.75;                                        % Semimajor axis length, units
lambdas = -pi:pi/12:pi;                          % Azimuth range
etas = -1:.1:1;                                  % Elevation range

[dxyz, npts] = plt_os(e, a, lambdas, etas, 1);
fprintf('\nIf this were the earth with an eccentricity of %1.2f,', e);
fprintf(' the\naccumulated error over');
fprintf(' %i points is %1.2e meters', npts, 6378137*(dxyz/a));

  % Make sure p_etas and p_lambdas are the same size...
p_lambdas = -pi:30*pi/180:pi;
p_etas = -.9:.15:.9;
p_npts = size(p_lambdas, 2);
for ii = 1:p_npts
  xyz = mth_os2cart(e, a, p_lambdas(ii), p_etas(ii));
  scatter3(xyz(1,:), xyz(2,:), xyz(3,:), 55, .9, 'filled');
  plt_os_covariant(e, a, p_lambdas(ii), p_etas(ii));
end

[dxyz, npts] = plt_os(e, a, lambdas, etas, 0);
for ii = 1:p_npts
  xyz = mth_os2cart(e, a, p_lambdas(ii), p_etas(ii));
  scatter3(xyz(1,:), xyz(2,:), xyz(3,:), 55, .9, 'filled');
  plt_os_contravariant(e, a, p_lambdas(ii), p_etas(ii));
end


lambda = lambdas(18);
eta = etas(18);
[e_1, e_2, e_3] = mth_os_cov_basis(e, a, lambda, eta);
[e1, e2, e3] = mth_os_cont_basis(e, a, lambda, eta);
fprintf("\n\nExpect three ones\n");
dot(e1,e_1)
dot(e2,e_2)
dot(e3,e_3)
fprintf("\nExpect six zeros\n");
dot(e1,e_2)
dot(e1,e_3)
dot(e2,e_3)
dot(e2,e_1)
dot(e3,e_1)
dot(e3,e_2)
fprintf("\nNorm of covariant then contravariant basis vectors\n");
norm(e_1)
norm(e_2)
norm(e_3)
norm(e1)
norm(e2)
norm(e3)
fprintf("\ng_ij*gij\n");
g_ij = mth_os_mt_cov(e, a, eta);
gij = mth_os_mt_cont(e, a, eta);
g_ij*gij

fprintf('\n');
