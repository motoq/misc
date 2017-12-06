function plt_sphere_pnt(r, theta, phi)
% PLT_SPHERE_PNT Adds a Cartesian point to a plot via scatter3 using
% spherical coordinates.  The existing plot should already have
% the hold set to 'on' if it is to be preserved.
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

point_size = 5;
point_color = .9;
xyz = mth_sphere2cart(r, theta, phi);
scatter3(xyz(1,:), xyz(2,:), xyz(3,:), point_size, point_color, 'filled');

