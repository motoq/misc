function isxp = mth_is_xpt(pos, xp, Cov)
% MTH_IS_XPT determines if a point relative to a reference position is
% i) an intersection point to a hyperellipsoid, and ii) the first
% intersection (closest, vs. going through the surface to the other
% side).
%
%-----------------------------------------------------------------------
% Copyright 2022 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   pos  Nx1 dimensional reference point outside of covariance
%   xp   Nx1 dimensional point to test as an intersection point
%   Cov  NxN covariance representing a hyperellipsoid
%
% Return:
%   isxp  True if xp is an intersection point from the line origninating at
%         pos
%
% Kurt Motekew  2022/02/26

    % Moving the line from pos to xp by a differential inward (making
    % the range vector longer) results in Chi^x < 1, and backing it out
    % makes Chi^2 > 1, if this is the first intersection point.
  pnt = xp - pos;
  pntmag = norm(pnt);
  pnthat = pnt/pntmag;
  delta = 0.001*pntmag;
    % Differential offset
  pnt1 = (pntmag + delta)*pnthat;
  pnt2 = (pntmag - delta)*pnthat;
  xp1 = pos + pnt1;
  xp2 = pos + pnt2;

  W = Cov^-1;
  chi2_1 = xp1'*W*xp1;
  chi2_2 = xp2'*W*xp2;

  if (chi2_1 < 1)  &&  (chi2_2 > 1)
    isxp = true;
  else
    isxp = false;
  end
