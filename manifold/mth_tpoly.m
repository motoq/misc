function tpoly = mth_tpoly(order, dt)
% MTH_TPOLY creates a Chebyshev polynomial
%
%-----------------------------------------------------------------------
% Copyright 2023 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Input:
%   order  Polynomial order (highest exponent)
%   dt     Independent parameter, [-1, 1]
%
% Return:
%   tpoly  order+1 row vector ordered highest exponent last
%
% Kurt Motekew   2023/03/05
%

  tpoly = ones(1, order+1);
  tpoly(2) = dt;
  for ii = 3:(order+1)
    tpoly(ii) = 2*dt*tpoly(ii-1) - tpoly(ii-2);
  end

