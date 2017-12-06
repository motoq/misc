function plt_vortex_covariant(k, zeye, lambda)
% PLT_VORTEX_COVARIANT Compute and plot the basis vectors in the
% tangent plane to the vortex manifold given a location and fit parameter.
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
%   k        Radius scaling factor coordinate (size and units)
%   zeye     Z coordinate, -inf < zeye < 0
%   lambda   Azimuth/longitude/right ascension coordinate, -pi <= lambda <= pi
%
% Kurt Motekew   2017/08/04
%

  % Orthogonal covariant vectors
xyz = mth_vortex2cart(k, zeye, lambda);
dxdv = mth_dcart_dvortex(k, zeye, lambda);
e1 = dxdv(:,2);
e1 = e1/norm(e1);
e2 = dxdv(:,3);
e2 = e2/norm(e2);
quiver3(xyz(1), xyz(2), xyz(3), e1(1), e1(2), e1(3),...
                               'color',[1,0,0],'linewidth',3);
quiver3(xyz(1), xyz(2), xyz(3), e2(1), e2(2), e2(3),...
                               'color',[0,1,0],'linewidth',3);
  % Non-orthogonal
e3 = dxdv(:,1);
e3 = e3/norm(e3);
quiver3(xyz(1), xyz(2), xyz(3), e3(1), e3(2), e3(3),...
        'color',[0,1,1],'linewidth',3);

