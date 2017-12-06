function plt_oblsph(r, thetas, phis, surf_opt)
% PLT_SPHERE Plots an sphere, creating a new figure and leaving the hold
% on.  Creates default 'X', 'Y', and 'Z' axes labels and a default
% title 'Sphere'.
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
%   r         Sphere size and units
%   thetas    Co-elevation (measured from z-axis), 0 <= phi <= pi
%   phis      Azimuth/right ascension, -pi <= lambda <= pi
%   surf_opt     0  No ellipsoid surface
%               >0  Add a surf based ellipsoid based on a covariance plot
%               <0  Add a mesh based ellipsoid based on a covariance plot
%
% Kurt Motekew   2017/08/29
%

nel = size(thetas,2);
naz = size(phis,2);

npts = nel*naz;

xyz = zeros(3, npts);
sizes = 5*ones(1,npts);

n = 1;
for ii = 1:naz
  for jj = 1:nel
    xyz(:,n) = mth_sphere2cart(r, thetas(jj), phis(ii));
    n = n + 1;
  end
end

figure; hold on;
if surf_opt ~= 0
  r2 = r*r;
  Sphere = [r2 0 0 ; 0 r2 0 ; 0 0 r2];
  if surf_opt > 0
    matrix3X3_plot(Sphere, 80, true);
  elseif surf_opt < 0
    matrix3X3_plot(Sphere, 80, false);
  end
end
scatter3(xyz(1,:), xyz(2,:), xyz(3,:), sizes);
title('Sphere');
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

