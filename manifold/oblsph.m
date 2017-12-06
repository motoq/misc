clear;
close all;

  % Define Oblate spheroid with fixed size
e = .9;                                          % Shape
a = 3.75;                                        % Semimajor axis length
%c = a*e;
b = a*sqrt(1 - e*e);                             % 'Fit" Spheroid

etas = -1:.1:1;
lambdas = -pi:pi/12:pi;

[dxyz1, dxyz2, npts] = plt_oblsph(a, b, etas, lambdas, -1);

p_etas = -1:.25:1;
p_lambdas = -pi:45*pi/180:pi;
p_npts = size(p_etas, 2);
for ii = 1:p_npts
  plt_oblsph_pnt(a, b, p_etas(ii), p_lambdas(ii));
  plt_oblsph_covariant(a, b, p_etas(ii), p_lambdas(ii));
end

fprintf('\nIf this were the earth with an eccentricity of %1.2f,', e);
fprintf(' the\naccumulated error over');
fprintf(' %i points is %1.2e meters', npts, 6378137*(dxyz1/a));
fprintf('\nfor the first method and %1.2e meters', 6378137*(dxyz2/a));
fprintf(' for the second method\n');
