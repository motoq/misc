function [dxyz, npts] = plt_vortex(k, zeyes, lambdas)
% PLT_VORTEX Plots a vortex via scatter3, creating a new
% figure and leaving the hold on.  Creates default 'X', 'Y', and 'Z'
% axes labels and a default title 'Vortex'.
%
%-----------------------------------------------------------------------
% Copyright 2017 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   k        Radius scaling factor (size and units)
%   zeyes    Z coordinates, -inf < zeye < 0
%   lambdas  Azimuth/longitude/right ascension coordinates, -pi <= lambda <= pi
%
% Kurt Motekew   2017/08/04
%

nel = size(zeyes,2);
naz = size(lambdas,2);

npts = nel*naz;

xyz = zeros(3, npts);
dxyz = 0;
sizes = 3*ones(1,npts);

n = 0;
for ii = 1:naz
  for jj = 1:nel
    n = n + 1;
    xyz(:,n) = mth_vortex2cart(k, zeyes(jj), lambdas(ii));
      % Error computing
    [~, zeye, lambda] = mth_cart2vortex(xyz(:,n));
    xyzn = mth_vortex2cart(k, zeye, lambda);
    dxyz = dxyz + norm(xyz(:,n) - xyzn);
  end
end

figure; hold on;
scatter3(xyz(1,:), xyz(2,:), xyz(3,:), sizes);
title('Vortex');
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

