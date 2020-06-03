function [e1, e2] = mth_affine_cont_basis(a, b, theta)
% MTH_AFFINE_CONT_BASIS computes the contravariant basis vectors for the
% affine coordinate system.
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
%   a      Affine system u-axis scale factor
%   b      Affine system v-axis scale factor
%   theta  Angle between affine coordinate system basis vectors
%          The affine u-axis is assumed to be aligned with the Cartesian
%          x-axis. Radians.
%
% Return
%   Contravariant basis vectors (2x1)
%
% Kurt Motekew   2020/06/02
%

  e1 = [a 0]';
  e2 = [b*cos(theta) b*sin(theta)]';
