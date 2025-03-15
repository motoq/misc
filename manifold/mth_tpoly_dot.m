function dtpoly = mth_tpoly_dot(order, dt)
% MTH_TPOLY_DOT creates the derivative of the Chebyshev polynomial
% w.r.t. the independent parameter.
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
%   dtpoly  order+1 row vector with the first element zero
%
% Kurt Motekew   2023/03/05
%

    % 2nd kind
  upoly = ones(1, order);
  upoly(2) = 2*dt;
  for ii = 3:order
    upoly(ii) = 2*dt*upoly(ii-1) - upoly(ii-2);
  end

  dtpoly = zeros(1, order+1);
  dtpoly(2) = 1;
  for ii = 3:(order+1)
    dtpoly(ii) = (ii-1)*upoly(ii-1);
  end

