function xyz = mth_oblsph2cart(a, b, eta, lambda)
% MTH_OBLSPH2CART comptues Cartesian coordinates given 2D oblate spheroid
% coordinates using the semimajor axis as the fixed size ellipsoid fit
% parameter.
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
%   a        Ellipsoid size and units, semimajor axis
%   b        Ellipsoid fit, semiminor axis length
%   eta      Elevation, -1 <= eta <= 1
%   lambda   Azimuth/longitude/right ascension, -pi <= lambda <= pi
%
% Return   Cartesian coordinates in units of c, [3x1]
%
% Kurt Motekew   2017/07/30
%                2017/08/15 Modified to use a & b instead of b & c
%
  d = a*sqrt(1 - eta*eta);
  xyz(3,1) = b*eta;
  xyz(2,1) = d*sin(lambda);
  xyz(1,1) = d*cos(lambda);
