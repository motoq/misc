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


fprintf('\n');
