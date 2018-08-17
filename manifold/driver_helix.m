% Plots a helix as a parametric equation and then plots the tangent plane
% at a given point.  Orthogonal basis vectors using the arc length as the
% independent parameter to the parametric equations are then plotted.
%
% Kurt Motekew
% 2018/07/22
%

clear;
close all;

  % Helix definition and range over which to plot
r = 1;
c = .25;
t_curve = (-2*pi):.1:(2*pi);

[x, y, z] = mth_helix_parametric(t_curve, r, c);
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

[xd_s, xdd_s, n] = mth_helix_tdt(r, c, t);

  % Tangent: "t"
quiver3(x, y, z, xd_s(1), xd_s(2), xd_s(3), 'color',...
        [1, 0, 0], 'linewidth', 3);
  % Normal: "tdot"
quiver3(x, y, z, xdd_s(1), xdd_s(2), xdd_s(3),...
       'color', [0, 1, 0], 'linewidth', 3);
  % Normal to osculating plane
quiver3(x, y, z, n(1), n(2), n(3),...
        'color', [0, 0, 1], 'linewidth', 3);

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

  % Torsion
w2 = r*r + c*c;
tau = c/w2;
fprintf('\nTorsion:\t\t\t%1.4f', tau);

  % Compute rotation vector
[ut, up, ub] = mth_helix_tpb(r, c, t);
d = tau*ut + k*ub;
quiver3(x, y, z, d(1), d(2), d(3), 'color', [0, 0, 0], 'linewidth', 1);

Frenet = [0 k 0 ; -k 0 tau ; 0 -tau 0]*[ut' ; up' ; ub'];
dut = Frenet(1,:)';
dup = Frenet(2,:)';
dub = Frenet(3,:)';
quiver3(x, y, z, dut(1), dut(2), dut(3), 'color', [1, 0, 0], 'linewidth', 1);
quiver3(x, y, z, dup(1), dup(2), dup(3), 'color', [0, 1, 0], 'linewidth', 1);
quiver3(x, y, z, dub(1), dub(2), dub(3), 'color', [0, 0, 1], 'linewidth', 1);
fprintf('\nDarboux (rotation) vector dot...');
fprintf('\ndot(d, Ddot):\t%1.3e', dot(d, dut));
fprintf('\ndot(d, Pdot):\t%1.3e', dot(d, dup));
fprintf('\ndot(d, Bdot):\t%1.3e', dot(d, dub));


box off;
axis equal;

[ut, up, ub] = mth_helix_tpb(r, c, t_curve);
figure; hold on;
plot3(ut(1,:), ut(2,:), ut(3,:), 'ro');
plot3(up(1,:), up(2,:), up(3,:), 'bo');
plot3(ub(1,:), ub(2,:), ub(3,:), 'go');
Sphere = [r*r 0 0 ; 0 r*r 0 ; 0 0 r*r];
matrix3X3_plot(Sphere, 40, false);
legend('t', 'p', 'b');
title('Indicatrix');

box off;
axis equal;

fprintf('\n');
