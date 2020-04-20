function xyz = mth_abyss2cart(r, lambda, kappa)
% MTH_ABYSS2CART comptues Cartesian coordinates given abyss coordinates
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
%   r        Radial position
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%   kappa    Depth
%
% Return   Cartesian coordinates in units of r, [3x1]
%
% Kurt Motekew   2020/04/18
%
  xyz(3,1) = -kappa/r;
  xyz(2,1) = r*sin(lambda);
  xyz(1,1) = r*cos(lambda);
