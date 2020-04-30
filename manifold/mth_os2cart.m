function xyz = mth_os2cart(e, a, lambda, eta)
% MTH_OS2CART comptues Cartesian coordinates given oblate spheroid
% coordinates.  This version treats the semimajor axis as one of the
% OS coordinates.
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
%   e        Eccentricity, ellipsoid fit
%   a        Ellipsoid semimajor axis coordinate, defines size and units
%   lambda   Azimuth coordinate, -pi <= lambda <= pi
%   eta      Elevation coordinate, -1 <= eta <= 1
%
% Return   Cartesian coordinates in units of a, [3x1]
%
% Kurt Motekew   2020/04/29
%

  sqometa2 = sqrt(1 - eta*eta);

  xyz(3,1) = a*eta*sqrt(1 - e*e);
  xyz(2,1) = a*sqometa2*sin(lambda);
  xyz(1,1) = a*sqometa2*cos(lambda);
