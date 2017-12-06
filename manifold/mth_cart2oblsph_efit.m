function [b, eta, lambda] = mth_cart2oblsph_efit(e, xyz)
% MTH_CART2OBLSPH_EFIT comptues oblate spheroid coordinates given Cartesian
% coordinates and an ellipsoid eccentricity as the fit parameter.
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
%   e        Eccentricity, ellipsoid fit
%   xyz      Cartesian coordinates to convert to oblate spheroidal coordinates
%
% Return
%   b        Semiminor axis, units of xyz
%   eta      Elevation, -1 <= eta <= 1
%   lambda   Azimuth/longitude/right ascension, -pi <= lambda <= pi
%
% Kurt Motekew   2017/08/14
%

  x2 = xyz(1)*xyz(1) + xyz(2)*xyz(2);
  y2 = xyz(3)*xyz(3);
  ome2 = 1 - e*e;
  b2 = x2*ome2 + y2;
  eta = xyz(3)/sqrt(b2);

  lambda = atan2(xyz(2), xyz(1));

  b = sqrt(b2);
