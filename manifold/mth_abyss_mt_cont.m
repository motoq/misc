function Zij = mth_abyss_mt_cont(r, kappa)
% MTH_ABYSS_MT_CONT computes the contravariant matric tensor Z^ij of the
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
%   Zij   Covariant metric tensor, 3x3
%         Z1 = r, z2 = kappa, z3 = lambda
%
% Kurt Motekew   2020/04/20
%

  Zij = zeros(3);

  r2 = r*r;
  r2inv = 1/r2;
  k2 = kappa*kappa;

  Zij(1,1) = 1;
  Zij(2,2) = r2 + r2inv*k2;
  Zij(3,3) = r2inv;
  Zij(1,2) = kappa/r;
  Zij(2,1) = Zij(1,2);
