function plt_plane(n, p, xvals, yvals)
% PLT_PLANE plots a plane given a normal vector and point on the plane.
% Standard form:  ax + by + cz = d, or n*x' = n*p' = d
% Plotted via point normal form.
%
%-----------------------------------------------------------------------
% Copyright 2018 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   n      A vector normal to the plane, [3x1]
%   p      A point on the plane, [3x1]
%   xvals  Range of x values
%   yvals  Range of y values
%
% Kurt Motekew  2018/07/21
%

  d = n'*p;
  
  [x, y] = ndgrid(xvals, yvals);
  z = (d - n(1)*x - n(2)*y)/n(3);

  mesh(x, y, z);
  hold on;
