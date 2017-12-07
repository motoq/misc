clear;
close all;

  % Define vortex
k = 2;                                           % Size/units

zeyes = -.3:-.1:-10;
lambdas = -pi:pi/12:pi;

[dxyz, npts] = plt_vortex(k, zeyes, lambdas);

p_zeyes = -.5:-.5:-6.5;
p_lambdas = -pi:30*pi/180:pi;
p_npts = size(p_zeyes, 2);
for ii = 1:p_npts
  plt_vortex_pnt(k, p_zeyes(ii), p_lambdas(ii));
  plt_vortex_covariant(k, p_zeyes(ii), p_lambdas(ii));
end

  % Create ellipse - start with reference size of 1 then scale by k
a = 3.5;
b = 2.1;
e = sqrt(1 - b*b/(a*a));
c = a*e;
[xvals, yvals] = mth_ellipse(c, 0, a, b, 3*pi/4, 40);
plt_vortex_xy(k, xvals, yvals);

axis equal;
axis off;
view([150, 20])

fprintf('\nThe accumulated error over');
fprintf(' %i points is %1.2e meters\n', npts, 6378137*(dxyz/k));
