function gr = mth_grad_mah(pos, Cov)
% MTH_GRAD_MAH Computes the gradient of the Mahalanobis distance
%
%-----------------------------------------------------------------------
% Copyright 2023 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Input:
%   pos  Position vector, Nx1
%   Cov  Covariance, NxN, same units as pos
%
% Return:
%   gr  Gradient at position
%
% Kurt Motekew   2023/05/14
%

  W = Cov^-1;
  gr = W*pos/sqrt(pos'*W*pos);
