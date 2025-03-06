function [xpt, missed] = mth_nsphere_x(pos, pnt)
% MTH_NSPHERE_X computes the intersection point on a unit n-sphere
% given a location and pointing vector.  If there is no intersection,
% a zero vector is returned;
%
%-----------------------------------------------------------------------
% Copyright 2022 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs
%   pos  Position of a point external to the unit n-sphere from which the
%        tangent line will originate, nx1
%   pnt  pointing vector, nx1
%
% Return
%   xpt  Intersection point on a unit n-sphere
%
% Kurt Motekew  2022/10/17
% 

  pnt_hat = pnt/norm(pnt);
  alpha = 0;
  beta = 0;
  gamma = 0;
  n = size(pos, 1);
  for  ii = 1:n
    alpha = alpha + pnt_hat(ii)*pnt_hat(ii);
    beta = beta + pos(ii)*pnt_hat(ii);
    gamma = gamma + pos(ii)*pos(ii);
  end
  gamma = gamma - 1;

  missed = false;
  d = beta*beta - alpha*gamma;
  if d >= 0
    pmag = norm(pos);
    if pmag > 1
      fprintf('\nOutside Unit Circle on X');
      phat = pos/pmag;
      if norm(phat + pnt_hat) < 1
        s = -(beta + sqrt(d))/alpha;
      else
        fprintf('\nPointing above horizon');
        s = 0;
        missed = true;
      end
    else
      fprintf('\nInside Unit Circle on X');
      s = (-beta + sqrt(d))/alpha;
    end
  else
    s = 0;
    missed = true;
  end

  xpt = pos + s*pnt_hat;





