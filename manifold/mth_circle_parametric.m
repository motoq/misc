function [x, y] = mth_circle_parametric(t, r, dx, dy)
% MTH_CIRCLE_PARAMETRIC generates a circle of given radius and center offset
% as a function of an independent variable
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
%   t   Independent parameter, range of angles over which the curve is to
%       be generated, radians
%   r   Radius of circle to be generated
%   dx  Offset of circle center along the x-axis
%   dy  Offset of circle center along the y-axis
%
% Return:
%   x  Cartesian x coordinates, in units of r, of the circle
%   y  Cartesian y coordinates, in units of r, of the circle
%
% Kurt Motekew   2018/07/17
%

  x = dx + r*cos(t);
  y = dy + r*sin(t);

