function [r, zeye, lambda] = mth_cart2vortex(xyz)
% MTH_CART2VORTEX computes Cartesian coordinates given vortex coordinates
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
%   xyz      Cartesian coordinates to convert to convert
%
% Return
%   r        Radial distance, units of xyz
%   zeye     Z coordinate, -inf < zeye < 0
%   lambda   Azimuth/longitude/right ascension, -pi <= lambda <= pi
%
% Kurt Motekew   2017/08/04
%
  r = sqrt(xyz(1)*xyz(1) + xyz(2)*xyz(2));
  zeye = xyz(3);
  lambda = atan2(xyz(2), xyz(1));
