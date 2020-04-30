function [dxyz, npts] = plt_os(e, a, lambdas, etas, surf_opt)
% PLT_OS Plots an oblate spheroid via surf and scatter3, creating a new
% figure and leaving the hold on.  Creates default 'X', 'Y', and 'Z'
% axes labels and a default title 'Oblate Spheroid'.
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
%   e         Eccentricity
%   a         Ellipsoid size and units, semimajor axis
%   lambdas   Azimuth/longitude/right ascension array, -pi <= lambda <= pi
%   etas      Elevation array, -1 <= eta <= 1
%   surf_opt     0  No ellipsoid surface
%               >0  Add a surf based ellipsoid based on a covariance plot
%               <0  Add a mesh based ellipsoid based on a covariance plot
%
% Return:
%   dxyz  Accumulated error over all conversions (to oblate spheroidal
%         and back to Cartesian)
%
% Kurt Motekew   2020/04/29
%

nel = size(etas,2);
naz = size(lambdas,2);

npts = nel*naz;

xyz = zeros(3, npts);
dxyz = 0;
sizes = 10*ones(1,npts);

n = 1;
for ii = 1:naz
  for jj = 1:nel
    xyz(:,n) = mth_os2cart(e, a, lambdas(ii), etas(jj));

    [aloc, lambdaloc, etaloc] = mth_cart2os(xyz(:,n), e);
    xyzloc = mth_os2cart(e, aloc, lambdaloc, etaloc);
    dxyz = dxyz + norm(xyz(:,n) - xyzloc);

    n = n + 1;
  end
end

b = a*sqrt(1 - e*e);
figure; hold on;
if surf_opt ~= 0
  Ellipsoid = [a*a 0 0 ; 0 a*a 0 ; 0 0 b*b];
  if surf_opt > 0
    matrix3X3_plot(Ellipsoid, 80, true);
  elseif surf_opt < 0
    matrix3X3_plot(Ellipsoid, 80, false);
  end
end
scatter3(xyz(1,:), xyz(2,:), xyz(3,:), sizes);
stitle = sprintf('Oblate Spheroid with Eccentricity %1.2f', e);
title(stitle);
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

