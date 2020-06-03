% Illustrates an affine coordinate system with covariant and
% contravariant basis vectors.
%
% Kurt Motekew
% 2020/06/02
%

clear;

  % Define affine coordinate system parameters
  % x-axis aligns with u-axis
a = 4;
b = 2;
theta = pi*60/180;
u1 = 0;
u2 = 4;
us = u1:.1:u2;
v1 = 0;
v2 = 2;
vs = v1:.1:v2;

[dxy, npts] = plt_affine(a, b, theta, us, vs);
fprintf(' The accumulated error with');
fprintf(' %i points is %1.2e', npts, dxy);

[e_1, e_2] = mth_affine_cov_basis(a, b, theta);
quiver(0, 0, e_1(1), e_1(2), 'color', [1 0 0], 'linewidth', 3);
quiver(0, 0, e_2(1), e_2(2), 'color', [0 1 0], 'linewidth', 3);
  %
[e1, e2] = mth_affine_cont_basis(a, b, theta);
quiver(0, 0, e1(1), e1(2), 'color', [1 0 0], 'linewidth', 1);
quiver(0, 0, e2(1), e2(2), 'color', [0 1 0], 'linewidth', 1);

sxlabel = sprintf('x (u = %1.1f to %1.1f)', u1, u2);
xlabel(sxlabel);
sylabel = sprintf('y (v = %1.1f to %1.1f)', v1, v2);
xlabel(sxlabel);
stitle = sprintf(...
                'Affine Coordinates xf = %1.1f yf = %1.1f theta = %1.1f deg',...
                                                         a, b, 180*theta/pi);
title(stitle);
axis equal;

fprintf('\n');


fprintf("\n\nExpect two ones\n");
dot(e1,e_1)
dot(e2,e_2)
fprintf("\nExpect two zeros\n");
dot(e1,e_2)
dot(e2,e_1)
fprintf("\nNorm of covariant then contravariant basis vectors\n");
norm(e_1)
norm(e_2)
norm(e1)
norm(e2)

fprintf("\ng_ij*gij\n");
g_ij = mth_affine_mt_cov(a, b, theta);
gij = mth_affine_mt_cont(a, b, theta);
g_ij*gij

fprintf('\n');

