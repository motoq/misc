function plt_os_surfaces(e, a, lambda, eta)
% PLT_OS_SURFACES plots the oblate spheroidal coordinate surfaces
% The input coordinates and ellipsoid definition define a specific
% coordinate that is plotted.  The corresponding ellipsoid, longitudinal
% plane, and hyperboloid of one sheet coordinate surfaces, are plotted
% with the intersection of all three as the coordinate.
% The intersection is the coordinate.
%
% A new figure is created and hold is left on.
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
%   e        Eccentricity, ellipsoid fit
%   a        Ellipsoid semimajor axis coordinate, defines size and units
%   lambda   Azimuth coordinate, -pi <= lambda <= pi
%   eta      Elevation coordinate, -1 <= eta <= 1
%
% Kurt Motekew   2020/06/24
%


figure;  hold on;

lambdas = lambda:pi/24:(lambda+3*pi/2);           % Azimuth range
etas = -1:.05:1;                                  % Elevation range
[L, E] = meshgrid(lambdas, etas);

  % First plot hyperboloid of one sheet
X = zeros(size(L));
Y = X;
Z = X;
rows = size(X,1);
cols = size(X,2);
c = a*e;
  % Define hyperboloid of one sheet semimajor axis given
  % ellipsoid definition
a_h = c*sqrt(1 - eta*eta);
for ii = 1:rows
  for jj = 1:cols
    xyz = mth_hyp2cart(a_h, L(ii,jj), E(ii,jj));
    X(ii,jj) = xyz(1);
    Y(ii,jj) = xyz(2);
    Z(ii,jj) = xyz(3);
  end
end
mesh(X, Y, Z);

  % Plot the oblate spheroid
for ii = 1:rows
  for jj = 1:cols
    xyz = mth_os2cart(e, a, L(ii,jj), E(ii,jj));
    X(ii,jj) = xyz(1);
    Y(ii,jj) = xyz(2);
    Z(ii,jj) = xyz(3);
  end
end
mesh(X, Y, Z);

  % Use z-axis bounds for hyperboloid for azimuth plane 
xyz = mth_hyp2cart(a_h, lambda, 1);
r = 2*xyz(3);
h = xyz(3);
x = [0 r*cos(lambda) r*cos(lambda) 0 0];
y = [0 r*sin(lambda) r*sin(lambda) 0 0];
z = [-h -h h h -h];
plot3(x, y, z, 'color', [0,0,0], 'linewidth',2);

  % Plot the coordinate and draw a line from the origin
xyz = mth_os2cart(e, a, lambda, eta);
scatter3(0, 0, 0, 100, 1, 'filled');
scatter3(xyz(1), xyz(2), xyz(3), 100, 1, 'filled');
plot3([0 xyz(1)], [0 xyz(2)], [0 xyz(3)], 'color', [.5,1,1], 'linewidth', 3);

xlabel('X');
ylabel('Y');
zlabel('Z');
colormap([.0 .0 .0]);
axis equal;
axis off;

