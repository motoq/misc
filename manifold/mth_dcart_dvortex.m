function dxdv = mth_dcart_dvortex(k, zeye, lambda)
% MTH_DCART_DVORTEX computes the partials of 3D Cartesian coordinates
% w.r.t. 3D vortex coordinates composed of a z axis position and an
% azimuth/longitude.
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
%   k        Radius scaling factor coordinate (size and units)
%   zeye     Z coordinate, -inf < zeye < 0
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%
% Return
%   dxdv   Partial of Cartesian w.r.t. vortex coordinates
%
%                 -                           -
%                 | dx/dk  dx/zeye  dx/dlambda |
%          dxdo = | dy/dk  dy/zeye  dy/dlambda |
%                 | dz/dk  dz/zeye  dz/dlambda |
%                 -                           -
% Kurt Motekew   2017/08/04
%                2017/08/21  Added d/dk
%

    % Undefined point, but just in case
  if zeye == 0
    r = 0;
    koz2 = 0;
    zinv = 0;
  else
    r = - k/zeye;
    koz2 = k/(zeye*zeye);
    zinv = 1/zeye;
  end
  cl = cos(lambda);
  sl = sin(lambda);

  dxdv = [ -cl*zinv  koz2*cl  -r*sl  ;  -sl*zinv  koz2*sl  r*cl  ;  0  1  0 ];
