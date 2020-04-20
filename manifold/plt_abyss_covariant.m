function plt_abyss_covariant(r, lambda, kappa)
% PLT_ABYSS_COVARIANT Compute and plot the covariant basis vectors to
% the abyss manifold.  Radial (red), Lambda (green), Kappa (blue).
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
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%   kappa    Depth
%
% Kurt Motekew   2020/04/21
%

  % Orthogonal covariant basis vectors
xyz = mth_abyss2cart(r, lambda, kappa);
dxda = mth_dcart_dabyss(r, lambda, kappa);
e1 = dxda(:,1);
e2 = dxda(:,2);
  % Non-orthogonal
e3 = dxda(:,3);

  % Normalize for plotting
e1 = e1/norm(e1);
e2 = e2/norm(e2);
e3 = e3/norm(e3);
quiver3(xyz(1), xyz(2), xyz(3), e1(1), e1(2), e1(3),...
                               'color',[1,0,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e2(1), e2(2), e2(3),...
                               'color',[0,1,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e3(1), e3(2), e3(3),...
        'color',[0,1,1],'linewidth',3);

