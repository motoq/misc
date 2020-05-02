function plt_os_contravariant(e, a, lambda, eta)
% PLT_OS_CONTRAVARIANT Compute and plot the oblate spheroid contravariant
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
%   e       Eccentricity
%   a       Ellipsoid size and units, semimajor axis
%   lambda  Azimuth, -pi <= lambda <= pi
%   eta     Elevation, -1 <= eta <= 1
%
% Kurt Motekew   2020/04/29
%

[e1, e2, e3] = mth_os_cont_basis(e, a, lambda, eta);

xyz = mth_os2cart(e, a, lambda, eta);
quiver3(xyz(1), xyz(2), xyz(3), e1(1), e1(2), e1(3),...
        'color',[1,0,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e2(1), e2(2), e2(3),...
        'color',[0,1,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e3(1), e3(2), e3(3),...
        'color',[0,0,1],'linewidth',3);
