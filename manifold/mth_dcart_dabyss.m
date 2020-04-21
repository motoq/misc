function dxda = mth_dcart_dabyss(r, kappa, lambda)
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
%   kappa    Depth
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%
% Return
%   dxda   Partial of Cartesian w.r.t. abyss coordinates
%
%                 -                              -
%                 | dx/dr  dx/dkappa  dx/dlambda |
%          dxdo = | dy/dr  dy/dkappa  dy/dlambda |
%                 | dz/dr  dz/dkappa  dz/dlambda |
%                 -                              -
%
%               = [ e_r  e_kappa  e_lambda ]
%
% Kurt Motekew   2020/04/21
%

  cl = cos(lambda);
  sl = sin(lambda);
  invr = 1/r;
  invr2 = invr*invr;

  dxda = [     cl         0     -r*sl ;
               sl         0      r*cl ;
           kappa*invr2  -invr     0   ];

