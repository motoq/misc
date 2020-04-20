function Zij = mth_abyss_mt_con(r, lambda, kappa)
% MTH_ABYSS_MT_CON computes the contravariant matric tensor Z^ij of the
% abyss coordinate system.
%
%-----------------------------------------------------------------------
% Copyright 2020 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   r        Radial position.  Undefined if r = 0
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%   kappa    Depth
%
% Return
%   Zij   Covariant metric tensor, 3x3
%
% Kurt Motekew   2020/04/20
%

    % Undefined point, but just in case
  Zij = zeros(3);

  r2 = r*r;
  r2inv = 1/r2;
  k2 = kappa*kappa;

  Zij(1,1) = 1;
  Zij(2,2) = r2inv;
  Zij(3,3) = r2 + r2inv*k2;
  Zij(1,3) = kappa/r;
  Zij(3,1) = Zij(1,3);
