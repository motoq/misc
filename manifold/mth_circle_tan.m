function [tp] = mth_circle_tan(pos, pnt)
% MTH_CIRCLE_TAN computes the tangent point to a unit circle from
% the input point that is most closely aligned with the input pointing
% vector.  The unit circle is centered at the origin of the coordinate
% system.
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
%   pos  Locate of point from which to find tangent to circle, 2x1
%   pnt  Pointing vector for which tangent line is supposed to be
%        closest too (there are two tangent points for each point not on
%        the circle).
%
% Return
%   tp  Tangent point to the unti circle
%
% Kurt Motekew  2022/01/26
% 

  r2 = pos'*pos;
  rmag = sqrt(r2);
  rhat = pos/rmag;

  s2 = r2 - 1;
  if s2 <= 0
    tp = rhat;
    return;
  end
  s = sqrt(s2);
  sa = 1/rmag;
  ca = s*sa;
 
  rhat_orth = [-rhat(2) ; rhat(1)];
  
  tpa = rhat*(rmag - s*ca);
  tpb = rhat_orth*s*sa;
  if pnt'*rhat_orth > 0
    tp = tpa + tpb;
  else
    tp = tpa - tpb;
  end
