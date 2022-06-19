function x = mth_cross(U)
% MTH_CROSS Computes the cross product for N-dimensional Cartesian
% vectors such than N is 2-dimensions or greater.  The resulting vector is
% orthogonal to each input column vector.  The order of operation is
% from left to right (increasing column index).
%
% Note:  Increasingly higher dimensions do start showing signs of numerical
% error in that the dot product grows in size.  For 2D, the dot product
% will be zero.  For 3D it will be on par with the standard cross
% product formula.  For 6D _unit_ vectors, the error is on the order of
% 1e-14 and grows to by about a factor of 10 for each additional
% dimension (e.g., 1e-11 for 9D).
%
%-----------------------------------------------------------------------
% Copyright 2022 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Input
%   U  Nx(N-1), N >= 2, matrix of N-dimensional column vectors.
%
% Return
%   X  Nx1 vector orthogonal to each column vector of U.
%
% Kurt Motekew  2022/02/19
%

    % Minimum size check an initialize default output to nx1 zero vector
  n = size(U,1);
  if n < 2
    x = 0;
    return;
  end
    % Prep for accumulation or default error value
  x = zeros(n,1);
    % Ensure enough vectors for dimension, nxm input where m = n-1
  m = size(U,2);
  if n ~= (m+1)
    return;
  end

    % Compute and loop over unique permutations that result in nonzero
    % Levi-Civita symbols (+/- one in Cartesian space).  Outer loop
    % accumulates products for cross product vector components.
  pms = 1:n;
  pmat = perms(pms);
  np = size(pmat,1);
  for ii = 1:np
    prm = pmat(ii,:);
      % Form product to be accumulated for the prm(1)'th component
    c = 1;
    for jj = 2:n
      c = c*U(prm(jj),jj-1);
    end
      % even or odd permutation
    Isp = speye(length(prm));
    s = det(Isp(:,prm));
    x(prm(1)) = x(prm(1)) +  s*c;
  end
    
