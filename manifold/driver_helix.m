% Plots a helix as a parametric equation and then plots the tangent plane
% at a given point
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
  % Plot plane using point normal form
n = [c*sin(t)  -c*cos(t)  r]';
plt_plane(n, [x y z]', -r:r, -r:r);
xlabel('x');
ylabel('y');
zlabel('z');
title('Tangent Plane to a Helix');
box off;
axis equal;
