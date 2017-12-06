function plt_sphere_covariant(r, theta, phi)
% PLT_SPHERE_COVARIANT Compute and plot the basis vectors in the
% tangent plane to the spherical reference frame
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
%   r       Sphere size
%   theta   Co-elevation (measured from z-axis), 0 <= phi <= pi
%   phi     Azimuth/right ascension, -pi <= lambda <= pi
%
% Kurt Motekew   2017/08/29
%

  % Plot vectors tangent to oblate spheroid
xyz = mth_sphere2cart(r, theta, phi);
dxds = mth_dcart_dsphere(r, theta, phi);
e1 = dxds(:,2);
e1 = e1/norm(e1);
e2 = dxds(:,3);
ne2 = norm(e2);
if ne2 ~= 0
  e2 = e2/ne2;
end
quiver3(xyz(1), xyz(2), xyz(3), e1(1), e1(2), e1(3),...
        'color',[1,0,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e2(1), e2(2), e2(3),...
        'color',[0,1,0],'linewidth',3);

  % Plot covariant to b coordinate system vector
e3 = dxds(:,1);
ne3 = norm(e3);
e3 = e3/ne3;
quiver3(xyz(1), xyz(2), xyz(3), e3(1), e3(2), e3(3),...
        'color',[0,0,1],'linewidth',3);

