function [dxy, npts] = plt_affine(a, b, theta, us, vs)
% PLT_AFFINE Plots an affine coordinate system given a s
%
%-----------------------------------------------------------------------
% Copyright 2020 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   a      Affine system u-axis scale factor
%   b      Affine system v-axis scale factor
%   theta  Angle between affine coordinate system basis vectors
%          The affine u-axis is assumed to be aligned with the Cartesian
%          x-axis.
%   us     Array of affine coordinate u values to plot
%   vs     Array of affine coordinate v values to plot
%
% Kurt Motekew   2020/05/20
%

nu = size(us,2);
nv = size(vs,2);

npts = nu*nv;

xy = zeros(2, npts);
dxy = 0;

n = 1;
for ii = 1:nu
  for jj = 1:nv
    xy(:,n) = mth_affine2cart(a, b, theta, us(ii), vs(jj));

    [u, v] = mth_cart2affine(xy(:,n), a, b, theta);
    xyloc = mth_affine2cart(a, b, theta, u, v);
    dxy = dxy + norm(xy(:,n) - xyloc);
    n = n + 1;
  end
end

figure; hold on;
scatter(xy(1,:), xy(2,:));
stitle = sprintf('Affine Coordinates');
title(stitle);
xlabel('X');
ylabel('Y');
axis equal;

