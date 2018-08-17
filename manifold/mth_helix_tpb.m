function [ut, up, ub] = mth_helix_tpb(r, c, t);
% MTH_HELIX_TPB Computes unit basis vectors associated with a circular
% helix originating about the Cartesian reference frame origin and
% spiraling about the z-axis.
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
%   ut  Unit tangent vector
%   up  Unit rate of change of tangent vector 
%   ub  Unit binormal vector
%
% Kurt Motekew   2018/08/15
%

  [xd_s, xdd_s, nvec] = mth_helix_tdt(r, c, t);

  n = size(t,2);

  ut = zeros(3,n);
  up = zeros(3,n);
  ub = zeros(3,n);
  for ii = 1:n
    ut(:,ii) = xd_s(:,ii)/norm(xd_s(:,ii));
    up(:,ii) = xdd_s(:,ii)/norm(xdd_s(:,ii));
    ub(:,ii) = nvec(:,ii)/norm(nvec(:,ii));
  end

