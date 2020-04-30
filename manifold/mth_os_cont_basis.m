function [e1, e2, e3] = mth_os_cont_basis(e, a, lambda, eta)
% MTH_OS_CONT_BASIS computes the contravariant basis vectors for the
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
%   a        Semimajor axis coordinate, defines size and units
%   lambda   Azimuth coordinate, -pi <= lambda <= pi
%   eta      Elevation coordinate, -1 <= eta <= 1
%
% Return
%   Contravariant basis vectors (3x1) at a, lambda, eta
%
% Kurt Motekew   2020/04/29
%

  g_ij = mth_os_mt_cov(e, a, lambda, eta);
  gij = g_ij^-1;

  [e_1, e_2, e_3] = mth_os_cov_basis(e, a, lambda, eta);

    % Form illustrating tensor contraction vs. simple matrix multiply
  e1 = gij(1,1)*e_1 + gij(1,2)*e_2 + gij(1,3)*e_3;
  e2 = gij(2,1)*e_1 + gij(2,2)*e_2 + gij(2,3)*e_3;
  e3 = gij(3,1)*e_1 + gij(3,2)*e_2 + gij(3,3)*e_3;