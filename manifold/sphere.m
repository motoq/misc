clear;
close all;

  % Define Oblate spheroid with fixed size
r = 3.75;
thetas = 0:pi/12:pi;
phis = -pi:pi/12:pi;

plt_sphere(r, thetas, phis, 0);

p_npts = size(thetas, 2);
for ii = 1:p_npts
  plt_sphere_pnt(r, thetas(ii), phis(ii));
  plt_sphere_covariant(r, thetas(ii), phis(ii));
end

