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
v = v/norm(v);

  % Vector to project and reflect
x = 0.25*[3 2]';

  % Projection and reflection
P = v*v'/(v'*v);
Pn = eye(2) - v*v'/(v'*v);
F = eye(2) - 2*v*v'/(v'*v);
Po = eye(2) - 1.5*v*v'/(v'*v);

xp = P*x;
xpn = Pn*x;
xf = F*x;
xo = Po*x;

figure; hold on;
  % Reference axis
quiver(0, 0, v(1), v(2), 'color', [0 0 0], 'linewidth', 1,...
       'AutoScale','off');
%quiver(0, 0, -v(1), -v(2), 'color', [0 0 0], 'linewidth', 1,...
%       'AutoScale','off');
plot([0 -v(1)], [0 -v(2)], '-k')
  % Original vector
quiver(0, 0, x(1), x(2), 'color', [0 0 1], 'linewidth', 3,...
       'AutoScale','off');
  % Projection
quiver(0, 0, xp(1), xp(2), 'color', [1 0 0], 'linewidth', 1,...
       'AutoScale','off');
  % Projection onto normal
quiver(0, 0, xpn(1), xpn(2), 'color', [1 0 0], 'linewidth', 1,...
       'AutoScale','off');
  % Reflection
quiver(0, 0, xf(1), xf(2), 'color', [0 0 1], 'linewidth', 1,...
       'AutoScale','off');
  % Oblique projection
quiver(0, 0, xo(1), xo(2), 'color', [0 1 0], 'linewidth', 1,...
       'AutoScale','off');

  % Line from vector to reflection touches tip of projection onto
  % normal and oblique projection
plot([x(1) xf(1)], [x(2) xf(2)], '-k')

xlim([-1 1]);
ylim([-1 1]);
axis equal;
