function dxdlsd = mth_dcart_dlsd(e_b, e_c, a, az, el)
% MTH_DCART_DLSD computes the partials of 3D Cartesian coordinates
% w.r.t. ellipsoid coordinates composed of semiminor axis, azimuth,
% and elevation.
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
%   e_b   Eccentricity for 2nd (y) axis
%   e_c   Eccentricity for 3rd (z) axis
%   a     Ellipsoid semimajor axis coordinate, defines size and units
%   az    Azimuth coordinate, about z-axis, -pi <= lambda <= pi
%   el    Elevation w.r.t. x-y plane coordinate,  -pi/2 <= el <= pi/2
%
% Return
%   dxdlsd  Partials of Cartesian w.r.t. ellipsoid coordinates
%
%                      -                       _
%                      | dx/da  dx/daz  dx/del |
%             dxdlsd = | dy/da  dy/daz  dy/del |
%                      | dz/da  dz/daz  dz/del |
%                      -                       _
%
% Kurt Motekew   2020/07/06
%

  sqomeb2 = sqrt(1 - e_b*e_b);
  sqomec2 = sqrt(1 - e_c*e_c);
  saz = sin(az);
  caz = cos(az);
  sel = sin(el);
  cel = cos(el);

  dxdlsd = [ caz*cel          -a*saz*cel          -a*caz*sel         ;
             sqomeb2*saz*cel   a*sqomeb2*caz*cel  -a*sqomeb2*saz*sel ;
             sqomec2*sel       0                   a*sqomec2*cel      ];
