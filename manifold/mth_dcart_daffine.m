function dxda = mth_dcart_daffine(a, b, theta)
% MTH_DCART_DAFFINE computes the partials of 2D Cartesian coordinates
% w.r.t. 2D affine coordinates.
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
%   dxda   Partial of Cartesian w.r.t. affine coordinates
%
%                 -              -
%                 | dx/du  dx/dv |
%          dxda = | dy/du  dy/dv |
%                 -              -
%
% Kurt Motekew   2020/06/02
%

  stheta = sin(theta);

  dxda = [           1/a           0.0         ;
           -cos(theta)/(a*stheta)  1/(b*stheta) ];

