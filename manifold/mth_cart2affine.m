function [u, v] = mth_cart2affine(xy, a, b, theta)
% MTH_CART2_AFFINE computes 2D affine coordinates given 2D Cartesian
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
%   xy     Cartesian coordinates
%   a      Affine system u-axis scale factor
%   b      Affine system v-axis scale factor
%   theta  Angle between affine coordinate system basis vectors
%          The affine u-axis is assumed to be aligned with the Cartesian
%          x-axis.  Radians.
%
% Return
%  u  Affine coordinate u value
%  v  Affine coordinate v value
%
% Kurt Motekew   2020/05/30
%

  u = a*xy(1);
  v = b*(xy(1)*cos(theta) + xy(2)*sin(theta));
