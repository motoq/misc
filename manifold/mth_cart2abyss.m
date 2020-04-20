function [r, lambda, kappa] = mth_cart2abyss(xyz)
% MTH_CART2ABYSS computes abyss coordinates given Cartesian
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
%   xyz      Cartesian coordinates to convert to convert
%
% Return
%   r        Radial position, units of xyz
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%   kappa    Depth
%
% Kurt Motekew   2020/04/18
%
  r = sqrt(xyz(1)*xyz(1) + xyz(2)*xyz(2));
  lambda = atan2(xyz(2), xyz(1));
  kappa = -xyz(3)*r;
