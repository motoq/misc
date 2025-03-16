function upoly = mth_upoly(order, dt)
% MTH_UPOLY creates a Chebyshev polynomial of the 2nd kind
%
%-----------------------------------------------------------------------
% Copyright 2023, 2025 Kurt Motekew
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
%   upoly  order+1 row vector with the first element zero
%
% Kurt Motekew   2025/03/16
%

  upoly = ones(1, order+1);
  upoly(2) = 2*dt;
  for ii = 3:(order+1)
    upoly(ii) = 2*dt*upoly(ii-1) - upoly(ii-2);
  end

