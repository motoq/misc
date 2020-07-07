function plt_lsd_covariant(e_b, e_c, a, az, el)
% PLT_LSD_COVARIANT Compute and plot the oblate spheroid covariant
% basis vectors.
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
%   az    Azimuth coordinate, about z-axis, -pi <= az <= pi
%   el    Elevation w.r.t. x-y plane coordinate,  -pi/2 <= el <= pi/2
%
% Kurt Motekew   2020/07/06
%

[e_1, e_2, e_3] = mth_lsd_cov_basis(e_b, e_c, a, az, el);

xyz = mth_lsd2cart(e_b, e_c, a, az, el);
quiver3(xyz(1), xyz(2), xyz(3), e_1(1), e_1(2), e_1(3),...
        'color',[1,0,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e_2(1), e_2(2), e_2(3),...
        'color',[0,1,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e_3(1), e_3(2), e_3(3),...
        'color',[0,0,1],'linewidth',3);
