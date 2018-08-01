% Plots a helix as a parametric equation and then plots the tangent plane
% at a given point.  Orthogonal basis vectors using the arc length as the
% independent parameter to the parametric equations are then plotted.
%
% Kurt Motekew
% 2018/07/22
%

clear;

  % Helix definition and range over which to plot
r = 1;
c = .25;
t = (-2*pi):.1:(2*pi);

[x, y, z] = mth_helix_parametric(t, r, c);
figure; hold on;
plot3(x, y, z);

  % Location at which to plot the tangent plane
t = pi/4;
[x, y, z] = mth_helix_parametric(t, r, c);
scatter3(x, y, z);

  %
  % Use helix definition as a function of arc length for vectors (including
  % normal to osculating plane)
  %

w = sqrt(r*r + c*c);
s = t*w;
sow = s/w;
  % Tangent: "t"
xd_s = [-r*sin(sow)/w, r*cos(sow)/w, c/w]';
quiver3(x, y, z, xd_s(1), xd_s(2), xd_s(3));
  % Normal: "tdot"
w2 = w*w;
xdd_s = [-r*cos(sow)/w2, -r*sin(sow)/w2, 0]';
quiver3(x, y, z, xdd_s(1), xdd_s(2), xdd_s(3));

  % Normal to osculating plane
n = [c*sin(t)  -c*cos(t)  r]';
%n = cross(xd_s, xdd_s);
quiver3(x, y, z, n(1), n(2), n(3));

  % Plot osculating plane using point normal form
plt_plane(n, [x y z]', -r:r, -r:r);
xlabel('x');
ylabel('y');
zlabel('z');
title('Osculating Plane to a Helix and Radius of Curvature');
  % Plot normal plane
% too busy, plt_plane(xd_s, [x y z]', -r:r, -r:r);

fprintf('\ndot(Tangent, Normal):\t\t%1.3e', dot(xd_s, xdd_s));
fprintf('\ndot(Tangent, Plane Normal):\t%1.3e', dot(xd_s, n));
fprintf('\ndot(Normal, Plane Normal):\t%1.3e', dot(xdd_s, n));

k = norm(xdd_s);
rho = 1/k;
fprintf('\nCurvature:\t\t\t%1.4f', k);
fprintf('\nRadius of curvature:\t\t%1.4f', rho);

  % Center of curvature
m = [x y z]' + rho*xdd_s/k;
scatter3(m(1), m(2), m(3));

fprintf('\n');

box off;
axis equal;
