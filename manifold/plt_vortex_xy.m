function plt_vortex_xy(k, x, y)
% PLT_VORTEX Plots arrays of x and y coordinates in vortex space
% (z = -1/sqrt(x^2 + y^2))
%
%-----------------------------------------------------------------------
% Copyright 2017 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs
%   k        Radius scaling factor (size and units)
%   x   Array of x values
%   y   Array of y values
%

  z = -k./sqrt(x.*x + y.*y);
  plot3(x, y, z, '-k', 'LineWidth', 3);
