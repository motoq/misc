function dxdo = mth_dcart_doblsph_full(a, b, eta, lambda)
% MTH_DCART_DOBLSPH_FULL computes the partials of 3D Cartesian coordinates
% w.r.t. 3D oblate spheroidal coordinates composed of semiminor axis,
% elevation, and azimuth parameters.  The oblate spheroidal coordinate.
% This is the 3D version of mth_dcart_doblsph_full because the semiminor
% axis size is a 3rd coordinate vs. assuming a fixed size oblate spheroid.
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
%                 -                           -
%                 | dx/db  dx/deta  dx/dlambda |
%          dxdo = | dy/db  dy/deta  dy/dlambda |
%                 | dz/db  dz/deta  dz/dlambda |
%                 -                           -
% Kurt Motekew   2017/08/17
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
  dxdo = [ some2*cl -aee*cl  -d*sl  ;  some2*sl -aee*sl  d*cl  ; eta*b/a  b  0 ];

