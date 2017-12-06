function plt_oblsph_pnt(a, b, eta, lambda)
% PLT_OBLSPH_PNT Adds a Cartesian point to a plot via scatter3 using
% oblate spheroid coordinates.  The existing plot should already have
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
%   a       Ellipsoid size and units, semimajor axis
%   b       Ellipsoid fit, semiminor axis length
%   eta     Elevation, -1 <= eta <= 1
%   lambda  Azimuth/longitude/right array, -pi <= lambda <= pi
%
% Kurt Motekew   2017/07/30
%

point_size = 5;
point_color = .9;
xyz = mth_oblsph2cart(a, b, eta, lambda);
scatter3(xyz(1,:), xyz(2,:), xyz(3,:), point_size, point_color, 'filled');

