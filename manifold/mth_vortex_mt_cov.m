function gij = mth_vortex_mt_cov(k, zeye)
% MTH_VORTEX_MT_COV computes the covariant matric tensor g_i_j of the
% vortex coordinate system.
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
%   k        Radius scaling factor coordinate (size and units)
%   zeye     Z coordinate, -inf < zeye < 0
%
% Return
%   gij   Covariant metric tensor, 3x3
%
%                 -               -
%                 | gkk  gke  gkl |
%          dxdo = | gke  gee  gel |
%                 | gkl  gel  gll |
%                 -               -
% Kurt Motekew   2017/08/22
%

    % Undefined point, but just in case
  gij = zeros(3);
  k2 = k*k;
  z2 = zeye*zeye;
  z3 = zeye*z2;
  z4 = zeye*z3;
  if zeye ~= 0
    gij(1,1) = 1/z2;
    gij(2,2) = k2/z4 + 1;
    gij(3,3) = k2/z2;
    gij(1,2) = -k/z3;
    gij(2,1) = gij(1,2);
  end
