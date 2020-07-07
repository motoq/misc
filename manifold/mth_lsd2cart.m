function xyz = mth_lsd2cart(e_b, e_c, a, az, el)
% MTH_LSD2CART comptues Cartesian coordinates given ellipsoid
% coordinates.
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
%   e_b   Eccentricity for 2nd (y) axis
%   e_c   Eccentricity for 3rd (z) axis
%   a     Ellipsoid semimajor axis coordinate, defines size and units
%   az    Azimuth coordinate, about z-axis, -pi <= lambda <= pi
%   el    Elevation w.r.t. x-y plane coordinate,  -pi/2 <= el <= pi/2
%
% Return   Cartesian coordinates in units of a, [3x1]
%
% Kurt Motekew   2020/07/04
%

  xyz(3,1) = a*sqrt(1 - e_c*e_c)*sin(el);
  xyz(2,1) = a*sqrt(1 - e_b*e_b)*sin(az)*cos(el);
  xyz(1,1) = a*cos(az)*cos(el);
