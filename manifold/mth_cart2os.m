function [a, lambda, eta] = mth_cart2os(xyz, e)
% MTH_CART2OS comptues oblate spheroidal coordinates given Cartesian
% coordinates and an ellipsoid eccentricity as the fit parameter.
% This version treats the semimajor axis as one of the OS coordinates.
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
%   xyz  Cartesian coordinates to convert to oblate spheroidal coordinates
%   e    Eccentricity, ellipsoid fit
%
% Return
%   a        Semimajor axis coordinate, units of xyz
%   lambda   Azimuth coordinate, -pi <= lambda <= pi
%   eta      Elevation coordinate, -1 <= eta <= 1
%
% Kurt Motekew   2020/04/29
%

  x2y2 = xyz(1)*xyz(1) + xyz(2)*xyz(2);
  z2 = xyz(3)*xyz(3);
  ome2 = 1 - e*e;
  
  a = sqrt(x2y2 + z2/ome2);
  lambda = atan2(xyz(2), xyz(1));
  eta = xyz(3)/(a*sqrt(ome2));
%  eta = xyz(3)/sqrt(x2y2*ome2 + z2);

