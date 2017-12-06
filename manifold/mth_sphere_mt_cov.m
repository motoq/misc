function gij = mth_sphere_mt_cov(r, theta, phi)
% MTH_SPHERE_MT_COV computes the covariant matric tensor g_i_j of the
% spherical coordinate system.
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
%   r       Sphere size
%   theta   Co-elevation (measured from z-axis), 0 <= phi <= pi
%   phi     Azimuth/right ascension, -pi <= lambda <= pi
%
% Return
%   gij   Covariant metric tensor, 3x3
%
%                 -               -
%                 | grr  grt  gre |
%          dxdo = | grt  gtt  gel |
%                 | gre  gel  gpp |
%                 -               -
% Kurt Motekew   2017/08/29
%

  r2 = r*r;
  st = sin(theta);

  gij(3,3) = r2*st*st;
  gij(2,2) = r2;
  gij(1,1) = 1;
