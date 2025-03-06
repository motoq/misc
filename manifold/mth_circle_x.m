function [xpt, missed] = mth_circle_x(pos, pnt)
% MTH_CIRCLE_X computes the intersection point on a unit circle given
% a location and pointing vector from that location.  If there is no
% intersection, a zero vector is returned;
%
%-----------------------------------------------------------------------
% Copyright 2021 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs
%   pos  Position external to circle, origin of pointing vector, 2x1
%   pnt  Pointing vector, 2x1
% Return
%   xpt  Location on sphere of intersection.  Zero if no intersection.
%        2x1
%
% Kurt Motekew  2021/10/10
% 


  rx = pos(1);
  ry = pos(2);
  pnt_hat = pnt/norm(pnt);
  px = pnt_hat(1);
  py = pnt_hat(2);

  alpha = px*px + py*py;
  beta = rx*px + ry*py;
  gamma = rx*rx + ry*ry - 1;

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

