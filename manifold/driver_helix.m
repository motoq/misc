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
xd_s = [-r*sin(sow), r*cos(sow), c/w]';
quiver3(x, y, z, xd_s(1), xd_s(2), xd_s(3));
  % Normal: "tdot"
s2 = s*s;
xdd_s = [-r*s2*cos(sow), -r*s2*sin(sow), 0]';
quiver3(x, y, z, xdd_s(1), xdd_s(2), xdd_s(3));

  % Normal to osculating plane
%n = [c*sin(t)  -c*cos(t)  r]';  % As a function of t
% Using s appears more precise based on below dot products
n = cross(xd_s, xdd_s);
quiver3(x, y, z, n(1), n(2), n(3));

  % Plot osculating plane using point normal form
plt_plane(n, [x y z]', -r:r, -r:r);
xlabel('x');
ylabel('y');
zlabel('z');
title('Osculating Plane to a Helix');
  % Plot normal plane
% too busy, plt_plane(xd_s, [x y z]', -r:r, -r:r);

fprintf('\ndot(Tangent, Normal):\t\t%1.3e', dot(xd_s, xdd_s));
fprintf('\ndot(Tangent, Plane Normal):\t%1.3e', dot(xd_s, n));
fprintf('\ndot(Normal, Plane Normal):\t%1.3e', dot(xdd_s, n));


fprintf('\n');

box off;
axis equal;
