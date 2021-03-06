function Z_ij = mth_abyss_mt_cov(r, kappa)
% MTH_ABYSS_MT_COV computes the covariant matric tensor Z_ij of the
% abyss coordinate system.  Note it is a function of the range and depth
% parameters only.
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
%   r        Radial position.  Undefined if r = 0
%   kappa    Depth
%
% Return
%   Z_ij   Covariant metric tensor, 3x3.
%          Z_1 = r, z_2 = kappa, z_3 = lambda
%
% Kurt Motekew   2020/04/20
%

  Z_ij = zeros(3);

  r2 = r*r;
  r3 = r*r2;
  r4 = r*r3;
  k2 = kappa*kappa;

  Z_ij(1,1) = 1 + k2/r4;
  Z_ij(2,2) = 1/r2;
  Z_ij(3,3) = r2;
  Z_ij(1,2) = -kappa/r3;
  Z_ij(2,1) = Z_ij(1,2);
