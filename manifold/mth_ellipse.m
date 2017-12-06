function [xvals, yvals] = mth_ellipse(x0, y0, major, minor, orient, n)
% MTH_ELLIPSE Generates points representing an ellipse on a Cartesian grid
% given a center point, major/minor axes, and orientation angle.  The
% calling function specifies the number of points to be used to represent
% a closed (first point = last point) ellipse.
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
%   x0      X-coordinate of ellipse center
%   y0      Y-coordinate of ellipse center
%   major  Semi-major axis length
%   minor   Semi-minor axis length
%   orient  Angle from the y-axis, clockwise, radians
%   n       Number of points per ellipse quadrant.  Total returned will
%           be 4*n + 1
%
% Return
%   xvals   [Nx1] Array of x values
%   yvals   [Nx1] Array of y values
%
% author  01/01/98  rhp initial version
% author  02/23/13  kam Matlab version simplified for a Cartesian plane,
%                       greatly simplified over rhp's
%

  npts = 4*n + 1;
  xvals = zeros(npts,1);
  yvals = zeros(npts,1);

  x   = major;
  y   = 0;
  del = major/n;

    % compute 1st quarter of ellipse
  xvals(1) = x;
  yvals(1) = y;
  for ii = 2:n
    x = x - del;
    y = sqrt(minor*minor*(1 - x*x/(major*major)));
    xvals(ii) = x;
    yvals(ii) = y;
  end

  xvals(n+1) = 0;
  yvals(n+1) = minor;
    % 2nd quater is a reflection of the first negate x values
  istart = n+2;
  istop  = istart + n - 2;
  ndx = n;
  for ii = istart:istop
    xvals(ii) = -xvals(ndx);
    yvals(ii) =  yvals(ndx);
    ndx = ndx - 1;
  end
  ndx = 2*n + 1;
  xvals(ndx) = -major;
  yvals(ndx) =  0;

  % 2nd half is symmetric to 1st - negate y values

  istart = 2*n+2;
  istop  = istart + 2*n - 2;
  ndx = 2*n;
  for ii = istart:istop
    xvals(ii) =  xvals(ndx);
    yvals(ii) = -yvals(ndx);
    ndx = ndx - 1;
  end
  ndx = 4*n + 1;

    % Close ellipse
  xvals(ndx) = xvals(1);
  yvals(ndx) = yvals(1);

    % First translate
  if (x0 ~= 0)  ||  (y0 ~= 0)
    for ii = 1:npts
      xvals(ii) = xvals(ii) + x0;
      yvals(ii) = yvals(ii) + y0;
    end
  end

    % rotate through orient angle
  if orient ~= 0
    sino = sin(orient);
    coso = cos(orient);
    for ii = 1:npts
      tx =  sino*xvals(ii) + coso*yvals(ii);
      ty =  coso*xvals(ii) - sino*yvals(ii);
      xvals(ii) = tx;
      yvals(ii) = ty;
    end
  end
