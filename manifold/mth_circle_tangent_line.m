function [x, y] = mth_circle_tangent_line(v, t, r, dx, dy)
% MTH_CIRCLE_TANGENT_LINE generates the tangent line to a circle given
% as a function of an independent variable.
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
%   v   Independent parameter, range of angles over which the curve is to
%       be generated, radians
%   t   Location on circle at which the tangent line is to be computed,
%       scalar, radians.
%   r   Radius of circle to be generated
%   dx  Offset of circle center along the x-axis
%   dy  Offset of circle center along the y-axis
%
% Return:
%   x  Cartesian x coordinates, in units of r, of the tangent line
%   y  Cartesian y coordinates, in units of r, of the tangent line
%
% Kurt Motekew   2018/07/17
%
  x = dx + r*cos(t) - r*v*sin(t);
  y = dy + r*sin(t) + r*v*cos(t);

