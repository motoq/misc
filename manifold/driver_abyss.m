% Plots an abyss along with basis vectors
%
% Kurt Motekew
% 2020/04/19
%

clear;

  % Plot fine resolution representation of abyss
rs = .1:.05:4;
lambdas = -pi:pi/12:pi;
kappa = .5;
compute_error = false;
[dxyz, npts] = plt_abyss(rs, lambdas, kappa, compute_error);
if compute_error
  fprintf('\nThe accumulated error over');
  fprintf(' %i points is %1.2e meters\n', npts, 6378137*dxyz);
end

  % Plot covariant basis vectors at coarse grid
rs = [.1 .2 .5:.5:4];
lambda = -pi;
dlambda = 30*pi/180;
p_npts = size(rs, 2);
point_size = 50;
point_color = .9;
for ii = 1:p_npts
  xyz = mth_abyss2cart(rs(ii), lambda, kappa);
  scatter3(xyz(1,:), xyz(2,:), xyz(3,:), point_size, point_color, 'filled');
  plt_abyss_covariant(rs(ii), lambda, kappa);
  lambda = lambda + dlambda;
end

axis equal;
view([150, 20])

