% Given a vector, compare the projection onto the normal of another
% vector vs. the reflection.  Note that the projection is 1/2 the
% reflection.
%
% Kurt Motekew
% 2019/02/26
%


close all;
clear;

  % Vector to base projection and refelction off of
v = [-.5 -2]';

  % Vector to project and reflect
x = [3 2]';

  % Projection and reflection
P = eye(2) - v*v'/(v'*v);
F = eye(2) - 2*v*v'/(v'*v);

xp = P*x;
xf = F*x;

figure; hold on;

  % Plot projection normal from end of vector of interest and from origin
quiver(0, 0, x(1), x(2), 'color', [0 0 0], 'linewidth', 3);
quiver(0, 0, v(1), v(2), 'color', [1 0 0], 'linewidth', 3);
  % Plot vector to project and reflect
quiver(x(1), x(2), v(1), v(2), 'color', [1 0 0], 'linewidth', 3);

  % Plot results
quiver(0, 0, xp(1), xp(2), 'color', [0 0 1], 'linewidth', 3);
quiver(0, 0, xf(1), xf(2), 'color', [0 1 0], 'linewidth', 3);


axis equal;
