function gij = mth_oblsph_mt_cov(a, b, eta, lambda)
% MTH_OBLSPH_MT_COV computes the covariant matric tensor g_i_j of the
% oblate spheroidal coordinate system.
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
%   gij   Covariant metric tensor, 3x3
%
%                 -               -
%                 | gaa  gae  gal |
%          dxdo = | gae  gee  gel |
%                 | gal  gel  gll |
%                 -               -
% Kurt Motekew   2017/08/27
%

    % Undefined point, but just in case
  gij = zeros(3);
  a2 = a*a;
  b2 = b*b;
  e2 = 1 - b2/a2;
  eta2 = eta*eta;
  ometa2 = 1 - eta2;
  ome2 = 1 - e2;

  gij(1,1) = ometa2 + ome2*eta2;
  gij(2,2) = a2*eta2/ometa2 + b2;
  gij(3,3) = a2*ometa2;
  g(1,2) = eta*(b*sqrt(ome2) - a);
