function [dxyz, npts] = plt_lsd(e_b, e_c, a, azs, els, surf_opt)
% PLT_LSD Plots an ellipsoid via surf and scatter3, creating a new
% figure and leaving the hold on.  Creates default 'X', 'Y', and 'Z'
% axes labels and a default title 'Ellipsoid'.
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
%   e_b       Eccentricity for 2nd (y) axis
%   e_c       Eccentricity for 3rd (z) axis
%   a         Ellipsoid semimajor axis coordinate, defines size and units
%   az        Azimuth coordinate, about z-axis, -pi <= az <= pi
%   el        Elevation w.r.t. x-y plane coordinate,  -pi/2 <= el <= pi/2
%   surf_opt    0  No ellipsoid surface
%              >0  Add a surf based ellipsoid based on a covariance plot
%              <0  Add a mesh based ellipsoid based on a covariance plot
%
% Return:
%  dxyz  Accumulated error over all conversions (to oblate spheroidal
%        and back to Cartesian)
%  npts  Number of points evaluated
%
% Kurt Motekew   2020/07/04
%

nel = size(els,2);
naz = size(azs,2);

npts = nel*naz;

xyz = zeros(3, npts);
dxyz = 0;
sizes = 10*ones(1,npts);

n = 1;
for ii = 1:naz
  for jj = 1:nel
    xyz(:,n) = mth_lsd2cart(e_b, e_c, a, azs(ii), els(jj));
    [aloc, azloc, elloc] = mth_cart2lsd(xyz(:,n), e_b, e_c);
    xyzloc = mth_lsd2cart(e_b, e_c, aloc, azloc, elloc);
    if ~isreal(xyzloc)
      fprintf('\nUnreal Cartesian');
    end
    delta = norm(xyz(:,n) - xyzloc);
    dxyz = dxyz + delta;
    n = n + 1;
  end
end

b = a*sqrt(1 - e_b*e_b);
c = a*sqrt(1 - e_c*e_c);
figure; hold on;
if surf_opt ~= 0
  Ellipsoid = [a*a 0 0 ; 0 b*b 0 ; 0 0 c*c];
  if surf_opt > 0
    matrix3X3_plot(Ellipsoid, 80, true);
  elseif surf_opt < 0
    matrix3X3_plot(Ellipsoid, 80, false);
  end
end
scatter3(xyz(1,:), xyz(2,:), xyz(3,:), sizes);
stitle = sprintf('Ellipsoid with Eccentricity %1.2f and %1.2f', e_b, e_c);
title(stitle);
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

