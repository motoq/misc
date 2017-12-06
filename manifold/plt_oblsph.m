function [dxyz1, dxyz2, npts] = plt_oblsph(a, b, etas, lambdas, surf_opt)
% PLT_OBLSPH Plots an oblate spheroid via scatter3, creating a new
% figure and leaving the hold on.  Creates default 'X', 'Y', and 'Z'
% axes labels and a default title 'Oblate Ellipsoid'.
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
%   a         Ellipsoid size and units, semimajor axis
%   b         Ellipsoid fit, semiminor axis length
%   etas      Elevation array, -1 <= eta <= 1
%   lambdas   Azimuth/longitude/right ascension array, -pi <= lambda <= pi
%   surf_opt     0  No ellipsoid surface
%               >0  Add a surf based ellipsoid based on a covariance plot
%               <0  Add a mesh based ellipsoid based on a covariance plot
%
% Return:
%   dxyz1  Accumulated error over all conversions (to oblate spheroidal
%         and back to Cartesian)
%   npts  Number of points over which error was computed.
%
% Kurt Motekew   2017/07/30
%

nel = size(etas,2);
naz = size(lambdas,2);

npts = nel*naz;

xyz = zeros(3, npts);
dxyz1 = 0;
dxyz2 = 0;
sizes = 5*ones(1,npts);

boa = b/a;
e = sqrt((1 - boa)*(1 + boa));

n = 1;
for ii = 1:naz
  for jj = 1:nel
    xyz(:,n) = mth_oblsph2cart(a, b, etas(jj), lambdas(ii));

    [eta, lambda] = mth_cart2oblsph(b, xyz(:,n));
    xyzn = mth_oblsph2cart(a, b, eta, lambda);
    dxyz1 = dxyz1 + norm(xyz(:,n) - xyzn);

    [~, eta, lambda] = mth_cart2oblsph_efit(e, xyz(:,n));
    xyzn = mth_oblsph2cart(a, b, eta, lambda);
    dxyz2 = dxyz2 + norm(xyz(:,n) - xyzn);


    n = n + 1;
  end
end

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
title('Oblate Spheroid');
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

