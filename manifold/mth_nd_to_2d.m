function T = mth_nd_to_2d(u, v, use_qr)
% MTH_ND_TO_2D Takes two N-dimensional vectors and determines the 
% orthonormal reference frame transformation that results in the two
% vectors being a linear combination of the new reference frame's first
% two basis vectors.  In this new reference frame, only the first two
% components of the u and v vectors are nonzero.  Linear combinations of
% the u and v vectors can be represented in two dimensions.  The inverse
% transformation converts results back to N-dimensional space.
% Basically, this function allows for taking a slice of N-dimensional
% space given two vectors defining that slice.
%
%-----------------------------------------------------------------------
% Copyright 2022 Kurt Motekew
%   
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   u       First Nx1 vector.  Will be parallel to the first basis vector for
%           odd dimensions and parallel to the second for even (e.g., for
%           3-d, (T*u)(1) = |u|, and for 4-d, (T*u)(2) = |u|).
%   v       Second Nx1 vector defining plane.  Only the first two components
%           of T*v are nonzero
%   use_qr  If true, use full QR decomposition instead of cross product
%           algorithm
%
% Output:
%   T  NxN, N-dimensional to 2D orthonormal transformation.  Not
%      orientation preserving for even dimensions
%
% Kurt Motekew  2022/02/23
%

    % Use full QR decomposition instead of cross products
  if use_qr
    %[Q, ~] = qr([u v]);
    [Q, ~] = mth_qr_hh([u v]);
    T = Q';
    return;
  end

  m = size(u,1);
  n = m-1;

  e1 = u;
  e2 = v;

  e1 = e1/norm(e1);
  e2 = e2/norm(e2);
    % Column vectors to cross, mxn
  U = mth_cross_build([e1 e2]);

    % Basis vectors
  E = zeros(m,m);
  E(:,1) = e1;
  for ii = 3:n
    ei = mth_cross(U);
    ei = ei/norm(ei);
    E(:,ii) = ei;
    U(:,ii) = ei;
  end
  em = mth_cross(U);
  em = em/norm(em);
  E(:,m) = em;

  for ii = 3:m
    U(:,ii-2) = E(:,ii);
  end
  U(:,n) = E(:,1);
  e2 = mth_cross(U);
  e2 = e2/norm(e2);
  E(:,2) = e2;        % Remove is preserving handedness
  %if mod(m,2) == 1   % Add back if preserving handedness
  %  E(:,2) = e2;
  %else
  %  E(:,1) = e2;
  %  E(:,2) = e1;
  %end

  T = E';
