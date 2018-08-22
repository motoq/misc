function [k, tau] = mth_helix_ktau(r, c, t);
% MTH_HELIX_KTAU Computes the curvature and torsion of a circular helix.
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
%   k    Curvature, [1xn]
%   tau  Torsion, [1xn]
%
% Kurt Motekew   2018/08/21
%

  n = size(t,2);

  w2 = r*r + c*c;
  w = sqrt(w2);

  k = zeros(1,n);
  tau = zeros(1,n);
  for ii = 1:n
    s = t(ii)*w;
    sow = s/w;
    k(ii) = norm([-r*cos(sow)/w2, -r*sin(sow)/w2, 0]');
    tau(ii) = c/w2;
  end

