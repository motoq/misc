function g_ij = mth_os_mt_cov(e, a, eta)
% MTH_OS_MT_COV computes the covariant matric tensor g_ij of the
% oblate spheroidal coordinate system.
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
%   a        Ellipsoid semimajor axis coordinate, defines size and units
%   eta      Elevation coordinate, -1 <= eta <= 1
%
% Return
%   gij   Covariant metric tensor, 3x3
%
%                 -               -
%                 | gaa  gal  gae |
%          dxdo = | gla  gll  gle |
%                 | gea  gel  gee |
%                 -               -
% Kurt Motekew   2020/04/29
%

  a2 = a*a;
  e2 = e*e;
  eta2 = eta*eta;
  ometa2 = 1 - eta2;

  g_ij = zeros(3);
  g_ij(1,1) = 1 - eta2*e2;
  g_ij(2,2) = a2*ometa2;
  g_ij(3,3) = a2*(1 - e2 + eta2/ometa2);
  g_ij(1,3) = -a*eta*e2;
  g_ij(3,1) = g_ij(1,3);
