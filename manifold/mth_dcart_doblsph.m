function dxdo = mth_dcart_doblsph(a, b, eta, lambda)
% MTH_DCART_DOBLSPH computes the partials of 3D Cartesian coordinates
% w.r.t. 2D oblate spheroidal coordinates composed of elevation and
% azimuth parameters.  The oblate spheroidal coordinate system is 2D
% because the semimajor axis is considered fixed, resulting in the radial
% distance always being on the same oblate spheroid definition.
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
%   a        Ellipsoid size and units, semimajor axis
%   b        Ellipsoid fit, semiminor axis length
%   eta      Elevation, -1 <= eta <= 1
%   lambda   Azimuth/longitude/right ascension, -pi <= lambda <= pi
%
% Return
%   dxdo   Partial of Cartesian w.r.t. oblate spheroidal coordinates
%
%                 -                    -
%                 | dx/deta  dx/dlambda |
%          dxdo = | dy/deta  dy/dlambda |
%                 | dz/deta  dz/dlambda |
%                 -                    -
% Kurt Motekew   2017/07/30
%

  some2 = sqrt(1 - eta*eta);
  if some2 == 0
    aee = 0;
  else
    aee = a*eta/some2;
  end
  cl = cos(lambda);
  sl = sin(lambda);
  d = a*some2;
  dxdo = [ -aee*cl  -d*sl  ;  -aee*sl  d*cl  ;  b  0 ];

