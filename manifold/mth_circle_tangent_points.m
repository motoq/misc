function [t1, t2] = mth_circle_tangent_points(dx1, dy1, dx2, dy2)
% MTH_CIRCLE_TANGENT_POINTS generates the location of the tangen points
% shared by two circles of equal radius.
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
%   dx1  Offset of first circle center along the x-axis
%   dy1  Offset of first circle center along the y-axis
%   dx2  Offset of second circle center along the x-axis
%   dy2  Offset of second circle center along the y-axis
%
% Return:
%   t1  First mutual tangent point location (independent parameter)
%   t2  Second mutual tangent point location (independent parameter)
%
% Kurt Motekew   2018/07/17
%

  t1 = atan((dx2 - dx1)/(dy1 - dy2));
  t2 = t1 + pi;
