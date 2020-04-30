function [dxyz, npts] = plt_abyss(rs, kappa, lambdas, compute_error)
% PLT_ABYSS Plots an abyss via scatter3, creating a new figure and
% leaving the hold on.  Creates default 'X', 'Y', and 'Z' axes labels
% and a default title 'Vortex'.
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
%   rs            Array of radial positions, distuance units
%   kappa         Chosen depth
%   lambda        Array of azimuths, -pi <= lambda <= pi
%   cmpute_error  Check accumulated error with conversions to/from
%                 Cartesian/Abyss coordinates
%
% Kurt Motekew   2020/04/18
%

nr = size(rs,2);
naz = size(lambdas,2);

npts = nr*naz;

xyz = zeros(3, npts);
dxyz = 0;
sizes = 3*ones(1,npts);

n = 0;
for ii = 1:naz
  for jj = 1:nr
    n = n + 1;
    xyz(:,n) = mth_abyss2cart(rs(jj), kappa, lambdas(ii));
      % Error computing
    if compute_error
      [r, k, lambda] = mth_cart2abyss(xyz(:,n));
      xyzn = mth_abyss2cart(r, k, lambda);
      dxyz = dxyz + norm(xyz(:,n) - xyzn);
    end
  end
end

scatter3(xyz(1,:), xyz(2,:), xyz(3,:), sizes);
stitle = sprintf('Abyss with depth factor %1.1f', kappa);
title(stitle);
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

