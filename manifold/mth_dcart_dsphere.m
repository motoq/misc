function dxds = mth_dcart_dsphere(r, theta, phi)
% MTH_DCART_SPHERE computes the partials of 3D Cartesian coordinates
% w.r.t. sphereical coordinates.
%
%-----------------------------------------------------------------------
% Copyright 2017 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   r       Sphere size
%   theta   Co-elevation (measured from z-axis), 0 <= phi <= pi
%   phi     Azimuth/right ascension, -pi <= lambda <= pi
%
% Return
%   dxds   Partial of Cartesian w.r.t. oblate spheroidal coordinates
%
%                 -                           -
%                 | dx/dr  dx/dtheta  dx/dphi |
%          dxds = | dy/dr  dy/dtheta  dy/dphi |
%                 | dz/dr  dz/dtheta  dz/dphi |
%                 -                           -
% Kurt Motekew   2017/08/29
%

  st = sin(theta);
  ct = cos(theta);
  sp = sin(phi);
  cp = cos(phi);

  dxds = [ st*cp r*ct*cp -r*st*sp ; st*sp r*ct*sp r*st*cp ; ct -r*st 0 ];
