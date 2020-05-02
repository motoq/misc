function gij = mth_os_mt_cont(e, a, eta)
% MTH_OS_MT_CONT computes the contravariant matric tensor gij of the
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
% Kurt Motekew   2020/05/01
%

  a2 = a*a;
  e2 = e*e;
  eta2 = eta*eta;
  ometa2 = 1 - eta2;
  ome2 = 1 - e2;

  gij = zeros(3);
  gij(1,1) = 1 + e2*eta2/ome2;
  gij(2,2) = 1/(a2*ometa2);
  gij(3,3) = ometa2*(1 - e2*eta2)/(a2*ome2);
  gij(1,3) = eta*e2*ometa2/(a*ome2);
  gij(3,1) = gij(1,3);
