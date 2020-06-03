function gij = mth_affine_mt_cont(a, b, theta)
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
%   gij  Contravariant metric tensor
%
%                 -               -
%          gij = | guu  guv |
%                 | gla  gll |
%                 -          -
% Kurt Motekew   2020/06/02
%

  gij = zeros(2);
  gij(1,1) = a*a;
  gij(2,2) = b*b;
  gij(1,2) = a*b*cos(theta);
  gij(2,1) = gij(1,2);
