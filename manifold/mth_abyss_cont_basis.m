function [e1, e2, e3] = mth_abyss_cont_basis(r, kappa, lambda)
% MTH_ABYSS_CONT_BASIS computes the contravariant basis vectors for the
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
%   r        Radial position, undefined for r = 0.
%   kappa    Depth
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%
% Return
%   Contravariant basis vectors (3x1) for r, kappa, lambda
%
% Kurt Motekew   2020/04/21
%

  cl = cos(lambda);
  sl = sin(lambda);
  rinv = 1/r;
  krinv = kappa*rinv;
  e1 = [ cl sl 0 ]';
  e2 = [ krinv*cl krinv*sl -r ]';
  e3 = [ -rinv*sl rinv*cl 0 ]';
