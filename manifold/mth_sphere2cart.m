function xyz = mth_sphere2cart(r, theta, phi)
% MTH_SPHERE2CART comptues Cartesian coordinates given spherical
% coordinates.
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
% Return   Cartesian coordinates in units of r, [3x1]
%
% Kurt Motekew   2017/08/29
%
  st = sin(theta);
  xyz(3,1) = r*cos(theta);
  xyz(2,1) = r*st*sin(phi);
  xyz(1,1) = r*st*cos(phi);
