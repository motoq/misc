function plt_abyss_contravariant(r, kappa, lambda)
% PLT_ABYSS_CONTRAVARIANT Compute and plot the contravariant basis vectors to
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
[e1, e2, e3] = mth_abyss_cont_basis(r, kappa, lambda);

  % Normalize for plotting then lengthen to distinguish from covariant
e1 = e1/norm(e1);
e2 = e2/norm(e2);
e3 = e3/norm(e3);
quiver3(xyz(1), xyz(2), xyz(3), e1(1), e1(2), e1(3),...
                               'color',[1,0,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e2(1), e2(2), e2(3),...
                               'color',[0,1,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e3(1), e3(2), e3(3),...
                               'color',[0,1,1],'linewidth',3);

