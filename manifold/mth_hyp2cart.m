function xyz = mth_hyp2cart(e, a, lambda, eta)
% MTH_HYP2CART computes Cartesian coordinates given hyperboloid of
% one sheet coordinates.
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
%   e        Eccentricity, shape 
%   a        Semimajor axis coordinate, defines size and units
%   lambda   Azimuth coordinate, -pi <= lambda <= pi
%   eta      Elevation coordinate, -1 <= eta <= 1
%
% Return   Cartesian coordinates in units of a, [3x1]
%
% Kurt Motekew   2020/06/17
%

  tmp = a*sqrt(1 + eta*eta);

  xyz(3,1) = a*e*eta;                            % c = a*e
  xyz(2,1) = tmp*sin(lambda);
  xyz(1,1) = tmp*cos(lambda);
