function [eta, lambda] = mth_cart2oblsph(b, xyz)
% MTH_CART2OBLSPH computes oblate spheroid coordinates given Cartesian
% coordinates and the semimajor axis as the ellipsoid fit (constraint)
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
%   b        Ellipsoid fit, semiminor axis length
%   xyz      Cartesian coordinates to convert to oblate spheroidal coordinates
%
% Return
%   eta      Elevation, -1 <= eta <= 1
%   lambda   Azimuth/longitude/right ascension, -pi <= lambda <= pi
%
% Kurt Motekew   2017/07/30
%

  eta = xyz(3)/b;
  lambda = atan2(xyz(2), xyz(1));
