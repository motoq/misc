function [pos, pnt, Cov] = app_nd_xtan_autogen(m)
% APP_ND_XTAN_AUTOGEN creates a symmetric positive definite matrix,
% reference point, and pointing vector given a dimension of interest,
% using randn.  These values are then passed to app_nd_xtan to generate
% tangent and intersection points, test, and plot results.
%
%-----------------------------------------------------------------------
% Copyright 2022 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Input:
%   m  Dimension for which to generate parameters.  If negative, the
%      covariance created will be the identity matrix.
%
% Return:
%   pos  Position of reference point, nx1
%   pnt  Pointing vector originating from reference point, nx1
%   Cov  Positive definite symmetric matrix of dimension 3 or greater,
%        nxn
%
% Kurt Motekew  2022/10/27
% 

    % Ensure symmetric
  if m > 0
    S = randn(m);
    Cov = S*S';
  else
    m = -m;
    Cov = eye(m);
  end
  W = Cov^-1;
  
    % Base reference point origin on size of hyperellipsoid
  [~, D] = eig(Cov);
  rng = sqrt(max(max(D)));
  pos = zeros(m,1);
  while sqrt(pos'*W*pos) <= 1
    pos = rng*randn(m,1);
  end
    % Point back down towards origin, then deviate
  pnt = -pos + rand(m,1);
  
    % Compute intersection and tangent, then plot results
  app_nd_xtan(pos, pnt, Cov);
