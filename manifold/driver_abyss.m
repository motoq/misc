% Plots an abyss along with basis vectors
%
% Kurt Motekew
% 2020/04/19
%

clear;

  % Plot fine resolution representation of abyss
rs = .1:.05:4;
kappa = .5;
lambdas = -pi:pi/12:pi;
compute_error = true;
figure; hold on;
[dxyz, npts] = plt_abyss(rs, kappa, lambdas, compute_error);
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
  xyz = mth_abyss2cart(rs(ii), kappa, lambda);
  scatter3(xyz(1,:), xyz(2,:), xyz(3,:), point_size, point_color, 'filled');
  plt_abyss_covariant(rs(ii), kappa, lambda);
  lambda = lambda + dlambda;
end
stitle =...
    sprintf('Abyss with depth factor %1.1f and covariant basis vectors', kappa);
title(stitle);
axis equal;
view([150, 20])

  % Plot contravariant basis vectors at coarse grid
figure; hold on;
[dxyz, npts] = plt_abyss(rs, kappa, lambdas, compute_error);
p_npts = size(rs, 2);
point_size = 50;
point_color = .9;
lambda = -pi;
for ii = 1:p_npts
  xyz = mth_abyss2cart(rs(ii), kappa, lambda);
  scatter3(xyz(1,:), xyz(2,:), xyz(3,:), point_size, point_color, 'filled');
  plt_abyss_contravariant(rs(ii), kappa, lambda);
  lambda = lambda + dlambda;
end
stitle =...
sprintf('Abyss with depth factor %1.1f and contravariant basis vectors', kappa);
title(stitle);
axis equal;
view([150, 20])

  % Plot shells at fine resolution
rs = .5:.05:4;
kappa = 1:10;
lambdas = -pi:pi/12:pi;
nk = size(kappa, 2);
figure; hold on;
for ii = 1:nk
  [dxyz, npts] = plt_abyss(rs, kappa(ii), lambdas, compute_error);
end
stitle = sprintf('Abyss with depth factor from %1.1f to %1.1f',...
                                                kappa(1), kappa(nk));
title(stitle);
