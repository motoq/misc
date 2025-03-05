function istp = mth_is_tanpt(pos, tp, Cov)
% MTH_IS_TANPT determines if a point relative to a reference position is
% a tangent point to a hyperellipsoid
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
%   tp   Nx1 dimensional point to test as a tangent point
%   Cov  NxN covariance representing a hyperellipsoid
%
% Return:
%   istp  True if tp is a tangent point from the line origninating at
%         pos
%
% Kurt Motekew  2022/02/26

    % Moving the line from pos to tp by a differential in either
    % direction should be outside of the hyperellipsoid (Chi^2 > 1)
    % From postion to tangent point
  pnt = tp - pos;
  pntmag = norm(pnt);
  pnthat = pnt/pntmag;
  delta = 0.001*pntmag;
    % Differential offset
  pnt1 = (pntmag + delta)*pnthat;
  pnt2 = (pntmag - delta)*pnthat;
  tp1 = pos + pnt1;
  tp2 = pos + pnt2;

  W = Cov^-1;
  chi2_1 = tp1'*W*tp1;
  chi2_2 = tp2'*W*tp2;

  if (chi2_1 > 1)  &&  (chi2_2 > 1)
    istp = true;
  else
    istp = false;
  end
