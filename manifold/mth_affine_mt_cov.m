function g_ij = mth_affine_mt_cov(a, b, theta)
% MTH_AFFINE_MT_COV computes the covariant matric tensor g_ij of the
% affine coordinate system.
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
%   a      Affine system u-axis scale factor
%   b      Affine system v-axis scale factor
%   theta  Angle between affine coordinate system basis vectors
%          The affine u-axis is assumed to be aligned with the Cartesian
%          x-axis. Radians.
%
% Return
%   g_ij  Covariant metric tensor, 2x2
%
%                 -               -
%          g_ij = | guu  guv |
%                 | gla  gll |
%                 -          -
% Kurt Motekew   2020/06/02
%

  ab = a*b;
  ct = cos(theta);
  st = sin(theta);
  st2 = st*st;
  g_ij = zeros(2);
  g_ij(1,1) = (1 + ct*ct/st2)/(a*a);
  g_ij(2,2) = 1/(b*b*st2);
  g_ij(1,2) = -ct/(a*b*st2);
  g_ij(2,1) = g_ij(1,2);
