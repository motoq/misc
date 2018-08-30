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

[x_curve, y_curve, z_curve] = mth_helix_parametric(t_curve, r, c);
figure; hold on;
plot3(x_curve, y_curve, z_curve);

  % Location at which to plot the tangent plane
t = pi/4;
[x, y, z] = mth_helix_parametric(t, r, c);
scatter3(x, y, z, 'filled');

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

  % Curvature and torsion
[k, tau] = mth_helix_ktau(r, c, t);
rho = 1/k;

fprintf('\nCurvature:\t\t\t%1.4f', k);
fprintf('\nRadius of curvature:\t\t%1.4f', rho);
fprintf('\nTorsion:\t\t\t%1.4f', tau);

  % Center of curvature
m = [x y z]' + rho*xdd_s/k;
scatter3(m(1), m(2), m(3), 'filled');

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

  % Osculating sphere
a = [x y z]' + rho*up;                 % Origin
r_os = norm([x y z]' - a);             % Radius
Sphere = [r_os*r_os 0 0 ; 0 r_os*r_os 0 ; 0 0 r_os*r_os];
[XX, YY, ZZ] = matrix3X3_points(Sphere, 40);   
figure; hold on;
mesh(XX + a(1), YY + a(2), ZZ + a(3), 'FaceAlpha', 0);
colormap([.1 .2 .3]);
plot3(x_curve, y_curve, z_curve);
quiver3(0, 0, 0, a(1), a(2), a(3), 'color', [0, 0, 0], 'linewidth', 3);
scatter3(x, y, z, 'filled');
scatter3(a(1), a(2), a(3), 'filled');
xlabel('x');
ylabel('y');
zlabel('z');
title('Osculating Sphere with Vector to Origin');

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


figure; hold on;
t = 0;
[k0, tau0] = mth_helix_ktau(r, c, t);
x1 = -1:.1:1;
zvec = zeros(size(x1));
x2 = k0*x1.*x1/2;
plot3(x1, x2, zvec);
x3 = k0*tau0*x1.*x1.*x1/6;
plot3(x1, zvec, x3);
x3 = sqrt(2)*tau0*sqrt(x2.*x2.*x2)/(3*sqrt(k0));
plot3(zvec, x2, x3);
xlabel('x1');
ylabel('x2');
zlabel('x3');
title('Shape of Neighboring Curve');

box off;

fprintf('\n');
