function [a, az, el] = mth_cart2lsd(xyz, e_b, e_c)
% MTH_CART2LSD comptues ellipsoid coordinates given Cartesian
% coordinates.
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
%   xyz  Cartesian coordinates to convert to oblate spheroidal coordinates
%   e_b  Eccentricity for 2nd (y) axis
%   e_c  Eccentricity for 3rd (z) axis
%
% Return
%   a    Ellipsoid semimajor axis coordinate, defines size and units
%   az   Azimuth coordinate, about z-axis, -pi <= lambda <= pi
%   el   Elevation w.r.t. x-y plane coordinate,  -pi/2 <= el <= pi/2
%
% Kurt Motekew   2020/07/04
%

  x2 = xyz(1)*xyz(1);
  y2 = xyz(2)*xyz(2);
  z2 = xyz(3)*xyz(3);
  omeb2 = 1 - e_b*e_b;
  omec2 = 1 - e_c*e_c;
  
  a = sqrt(x2 + y2/omeb2 + z2/omec2);
  az = atan2(xyz(2)/sqrt(omeb2), xyz(1));
  tmp = xyz(3)/(a*sqrt(omec2));
  if tmp > 1
    delta = tmp - 1;
    if delta > 1e-15;
      fprintf('\nDelta Sin El: %1.3e', delta);
    end
    tmp = 1;
  elseif tmp < -1
    delta = tmp + 1;
    if delta < -1e-15;
      fprintf('\nDelta Sin El: %1.3e', tmp + 1);
    end
    tmp = -1;
  end
  el = asin(tmp);
