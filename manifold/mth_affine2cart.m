function xy = mth_affine2cart(a, b, theta, u, v)
% MTH_AFFINE2CART computes 2D Cartesian coordinates given 2D affine
% coordinates.
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
%          x-axis.  Radians.
%   u      Affine coordinate u value
%   v      Affine coordinate v value
%
% Return   Cartesian coordinates, [2x1]
%
% Kurt Motekew   2020/05/29
%

  x = u/a;
  y = (-u*cos(theta)/a + v/b)/sin(theta);
  xy = [x y]';
