function xyz = mth_vortex2cart(k, zeye, lambda)
% MTH_VORTEX2CART comptues Cartesian coordinates given vortex coordinates
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
%   k        Radius scaling factor (size and units)
%   zeye     Z coordinate, -inf < zeye < 0
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%
% Return   Cartesian coordinates in units of k, [3x1]
%
% Kurt Motekew   2017/08/04
%
  r = -k/zeye;
  xyz(3,1) = zeye;
  xyz(2,1) = r*sin(lambda);
  xyz(1,1) = r*cos(lambda);
