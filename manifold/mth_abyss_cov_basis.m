function [e_1, e_2, e_3] = mth_abyss_cov_basis(r, kappa, lambda)
% MTH_ABYSS_COV_BASIS computes the covariant basis vectors for the
% abyss coordinate system.
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
%   r        Radial position, undefined for r = 0.
%   kappa    Depth
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%
% Return
%   Covariant basis vectors (3x1) for r, kappa, lambda
%
% Kurt Motekew   2020/04/21
%

  dxda = mth_dcart_dabyss(r, kappa, lambda);
  e_1 = dxda(:,1);
  e_2 = dxda(:,2);
  e_3 = dxda(:,3);
