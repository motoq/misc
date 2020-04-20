function dxda = mth_dcart_dabyss(r, lambda, kappa)
% MTH_DCART_DABYSS computes the partials of 3D Cartesian coordinates
% w.r.t. 3D abyss coordinates.  Each column of the resulting Jacobian
% is a covariant basis vector.
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
%   r        Radial position, undefined for r = 0.
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%   kappa    Depth
%
% Return
%   dxda   Partial of Cartesian w.r.t. abyss coordinates
%
%                 -                              -
%                 | dx/dr  dx/dlambda  dx/dkappa |
%          dxdo = | dy/dr  dy/dlambda  dy/dkappa |
%                 | dz/dr  dz/dlambda  dz/dkappa |
%                 -                              -
%
%               = [ e_r  e_lambda  e_kappa ]
%
% Kurt Motekew   2020/04/21
%

  cl = cos(lambda);
  sl = sin(lambda);
  invr = 1/r;
  invr2 = invr*invr;

  dxda = [     cl      -r*sl    0 ;
               sl       r*cl    0 ;
           kappa*invr2   0    -invr ];

