function [smajor, sminor, orient] = mth_cov2ellipse_eig(Sigma)
% MTH_COV2ELLIPSE_EIG computes the semimajor, minor, and orientation
% angle of a 2D covariance.  Uses the built in eig function vs.
% the direct approach for a 2x2.
%
%-----------------------------------------------------------------------
% Copyright 2018 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Input
%   Sigma   [2x2] Covariance
%
% Return
%   smajor    semi-major axis
%   sminor    semi-minor axis
%   orient    Orientation angle, clockwise from the y-axis, radians
%
% Kurt Motekew  2018/02/10
%

  [V, LAMBDA] = eig(Sigma);
  smajor = sqrt(LAMBDA(1,1));
  sminor = sqrt(LAMBDA(2,2));
  if smajor > sminor
    v = V(:,1)/norm(V(:,1));
  else
    tmp = smajor;
    smajor = sminor;
    sminor = tmp;
    v = V(:,2)/norm(V(:,2));
  end
    orient = atan2(v(1),v(2));
