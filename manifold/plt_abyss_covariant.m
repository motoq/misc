function plt_abyss_covariant(r, kappa, lambda)
% PLT_ABYSS_COVARIANT Compute and plot the covariant basis vectors to
% the abyss manifold.  Radial (red), Kappa (green), Lambda (blue).
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
%   r        Radial position
%   kappa    Depth
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%
% Kurt Motekew   2020/04/21
%

xyz = mth_abyss2cart(r, kappa, lambda);
[e_1, e_2, e_3] = mth_abyss_cov_basis(r, kappa, lambda);

  % Normalize for plotting
e_1 = e_1/norm(e_1);
e_2 = e_2/norm(e_2);
e_3 = e_3/norm(e_3);
quiver3(xyz(1), xyz(2), xyz(3), e_1(1), e_1(2), e_1(3),...
                               'color',[1,0,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e_2(1), e_2(2), e_2(3),...
                               'color',[0,1,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e_3(1), e_3(2), e_3(3),...
                               'color',[0,1,1],'linewidth',3);

