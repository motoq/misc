function [e_1, e_2, e_3] = mth_lsd_cov_basis(e_b, e_c, a, az, el)
% MTH_LSD_COV_BASIS computes the covariant basis vectors for the
% ellipsoid coordinate system.
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
%   Covariant basis vectors (3x1) at a, az, el
%
% Kurt Motekew   2020/07/06
%

  dxdlsd = mth_dcart_dlsd(e_b, e_c, a, az, el);
  e_1 = dxdlsd(:,1);
  e_2 = dxdlsd(:,2);
  e_3 = dxdlsd(:,3);
