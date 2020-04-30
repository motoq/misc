function dxdo = mth_dcart_dos(e, a, lambda, eta)
% MTH_DCART_DOS computes the partials of 3D Cartesian coordinates
% w.r.t. 3D oblate spheroidal coordinates composed of semiminor axis,
% elevation, and azimuth parameters.
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
%   e        Eccentricity, ellipsoid fit
%   a        Semimajor axis coordinate, defines size and units
%   lambda   Azimuth coordinate, -pi <= lambda <= pi
%   eta      Elevation coordinate, -1 <= eta <= 1
%
% Return
%   dxdo   Partial of Cartesian w.r.t. oblate spheroidal coordinates
%
%                 -                            -
%                 | dx/da  dx/dlambda  dx/deta |
%          dxdo = | dy/da  dy/dlambda  dy/deta |
%                 | dz/da  dz/dlambda  dz/deta |
%                 -                            -
% Kurt Motekew   2020/04/29
%

  sqome2   = sqrt(1 - e*e);
  sqometa2 = sqrt(1 - eta*eta);
  cl = cos(lambda);
  sl = sin(lambda);

  dxdo = [ sqometa2*cl  -a*sqometa2*sl  -a*eta*cl/sqometa2 ;
           sqometa2*sl   a*sqometa2*cl  -a*eta*sl/sqometa2 ;
           eta*sqome2    0.0             a*sqome2           ];

