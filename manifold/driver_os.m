% Plots an oblate spheroid along with basis vectors.  This version uses
% the ellipsoid semimajor axis as one of the OS coordinates.
%
% Kurt Motekew
% 2020/04
%

close all;
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
stitle = sprintf('Oblate Spheroid (e = %1.2f) and %s',...
                         e, 'Covariant Basis Vectors');
title(stitle);
axis equal;

plt_os(e, a, lambdas, etas, 0);
for ii = 1:p_npts
  xyz = mth_os2cart(e, a, p_lambdas(ii), p_etas(ii));
  scatter3(xyz(1,:), xyz(2,:), xyz(3,:), 55, .9, 'filled');
  plt_os_contravariant(e, a, p_lambdas(ii), p_etas(ii));
end
stitle = sprintf('Oblate Spheroid (e = %1.2f) and %s',...
                     e, 'Contravariant Basis Vectors');
title(stitle);
axis equal;

plt_os(e, a, lambdas, etas, 0);
for ii = 1:p_npts
  xyz = mth_os2cart(e, a, p_lambdas(ii), p_etas(ii));
  J = mth_dcart_dos(e, a, p_lambdas(ii), p_etas(ii));
  if mod(ii,2) == 0
    g_ij = mth_os_mt_cov(e, a, p_etas(ii));
    [XX, YY, ZZ] = matrix3X3_points((J^-1)'*g_ij*(J^-1), 40);
  else
    gij = mth_os_mt_cont(e, a, p_etas(ii));
    [XX, YY, ZZ] = matrix3X3_points(J*gij*J', 40);
  end
  surf(XX + xyz(1), YY + xyz(2), ZZ + xyz(3));
end
stitle = sprintf('Oblate Spheroid (e = %1.2f), Transformed Metric Tensor', e);
title(stitle);
axis equal;

lambda = lambdas(18);
eta = etas(18);
[e_1, e_2, e_3] = mth_os_cov_basis(e, a, lambda, eta);
[e1, e2, e3] = mth_os_cont_basis(e, a, lambda, eta);
fprintf("\n\ndot(ei, e_i) should be 1: %1.3f, %1.3f, %1.3f",...
                      dot(e1,e_1), dot(e2,e_2), dot(e3,e_3));
fprintf(...
  "\ndot(ei, e_j), should be 0: %1.3f, %1.3f, %1.3f %1.3f, %1.3f %1.3f",...
                                  dot(e1,e_2), dot(e1,e_3), dot(e2,e_3),...
                                  dot(e2,e_1), dot(e3,e_1), dot(e3,e_2));
fprintf("\nNorm of covariant basis vectors %1.3f %1.3f, %1.3f",...
                                          norm(e_1), norm(e_2), norm(e_3));
fprintf("\nNorm of contravariant basis vectors %1.3f %1.3f, %1.3f",...
                                                norm(e1), norm(e2), norm(e3));
g_ij = mth_os_mt_cov(e, a, eta);
gij = mth_os_mt_cont(e, a, eta);
fprintf("\ng_ij*gij - I = %1.3f", norm(norm(g_ij*gij - eye(3))));

g_ij = mth_os_mt_cov(e, a, eta);
figure;  hold on;
matrix3X3_plot(g_ij, 40, false);
J = mth_dcart_dos(e, a, lambda, eta);
g_ij = (J^-1)'*g_ij*(J^-1);
matrix3X3_plot(g_ij, 40, true);
xlabel('x');
ylabel('y');
zlabel('z');
title('Covariant Oblate Spheroid and Transformed Metric Tensors');
axis equal;

fprintf("\nJ'*gij*J - I = %1.3f", norm(norm(g_ij - eye(3))));


fprintf('\n');

plt_os(e, a, lambdas, etas, 0);
[e_1, ~, ~] = mth_os_cov_basis(e, a, lambda, eta);
xyz = mth_os2cart(e, a, lambda, eta);
quiver3(xyz(1), xyz(2), xyz(3), e_1(1), e_1(2), e_1(3),...
        'color',[1,0,0],'linewidth',3);
xyz = mth_os2cart(e, a, lambda+pi/4, eta+.2);
quiver3(xyz(1), xyz(2), xyz(3), e_1(1), e_1(2), e_1(3),...
        'color',[1,0,0],'linewidth',3);


stitle = sprintf('Oblate Spheroid (e = %1.2f)', e);
title(stitle);
axis equal;
