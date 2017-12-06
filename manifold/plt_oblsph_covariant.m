function plt_oblsph_covariant(a, b, eta, lambda)
% PLT_OBLSPH_COVARIANT Compute and plot the basis vectors in the
% tangent plane to the oblate spheroid given size and fit parameters.
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
%   a       Ellipsoid size and units, semimajor axis
%   b       Ellipsoid fit, semiminor axis length
%   eta     Elevation, -1 <= eta <= 1
%   lambda  Azimuth/longitude/right array, -pi <= lambda <= pi
%
% Kurt Motekew   2017/07/30
%

dxdo = mth_dcart_doblsph_full(a, b, eta, lambda);
  % Vectors tangent to 2D manifold in 3D space
e1 = dxdo(:,2);
e1 = e1/norm(e1);
e2 = dxdo(:,3);
ne2 = norm(e2);
if ne2 ~= 0
  e2 = e2/ne2;
end
  % Semimajor or minor axis tangent
e3 = dxdo(:,1);
ne3 = norm(e3);
e3 = e3/ne3;

xyz = mth_oblsph2cart(a, b, eta, lambda);
quiver3(xyz(1), xyz(2), xyz(3), e1(1), e1(2), e1(3),...
        'color',[1,0,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e2(1), e2(2), e2(3),...
        'color',[0,1,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e3(1), e3(2), e3(3),...
        'color',[0,0,1],'linewidth',3);
