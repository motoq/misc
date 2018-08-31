function [xd_s, xdd_s, xd_x_xdd] = mth_helix_tdt(r, c, t)
% MTH_HELIX_TDT Computes the tangent, rate of change of the tangent,
% and normal to these vectors, for a helix originating about the Cartesian
% reference frame origin and spiraling about the z-axis.
%
%-----------------------------------------------------------------------
% Copyright 2018 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   r   Radius parameter
%   c   Linear out of plane scaling parameter
%   t   Independent parameter, [1xn]
%
% Return
%   xd_s      Tangent vector, [3xn]
%   xdd_s     Rate of change of tangent vector, [3xn]
%   xd_x_xdd  Binormal vector (xd_s X xdd_s), [3xn]
%
% Kurt Motekew   2018/08/15
%

  n = size(t,2);

  w2 = r*r + c*c;
  w = sqrt(w2);

  xd_s = zeros(3,n);
  xdd_s = zeros(3,n);
  xd_x_xdd = zeros(3,n);
  for ii = 1:n
    s = t(ii)*w;
    sow = s/w;
    xd_s(:,ii) = [-r*sin(sow)/w, r*cos(sow)/w, c/w]';
    xdd_s(:,ii) = [-r*cos(sow)/w2, -r*sin(sow)/w2, 0]';
    xd_x_xdd(:,ii) = [c*sin(t(ii))  -c*cos(t(ii))  r]';
  end

