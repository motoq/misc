% Given two circles of the same size, both located in the x-y plane, compute
% the two shared tangent lines between the two and the four (two each)
% tangent points
%
% Kurt Motekew
% 2018/07/17
%

clear;

  % Radius of circles and their offsets from the center
r = 2;
xoff1 = -1;
yoff1 = 0;
xoff2 = 2;
yoff2 = -1;

  % Independent variable over which to plot the circles
t = 0:.1:(2*pi);

  % Circle plots
[x1, y1] = mth_circle_parametric(t, r, xoff1, yoff1);
[x2, y2] = mth_circle_parametric(t, r, xoff2, yoff2);
figure; hold on;
plot(x1, y1, 'b-', x2, y2, 'g-');

  % Independent variable over which to plot the tangent lines
v = -1:.1:1;

  % Location of tangent points
[t1, t2] = mth_circle_tangent_points(xoff1, yoff1, xoff2, yoff2);

[x, y] = mth_circle_parametric(t1, r, xoff1, yoff1);
plot(x, y, 'ro');
[x, y] = mth_circle_parametric(t2, r, xoff1, yoff1);
plot(x, y, 'ro');
[x, y] = mth_circle_parametric(t1, r, xoff2, yoff2);
plot(x, y, 'ro');
[x, y] = mth_circle_parametric(t2, r, xoff2, yoff2);
plot(x, y, 'ro');

[xt1, yt1] = mth_circle_tangent_line(v, t1, r, xoff1, yoff1);
[xt2, yt2] = mth_circle_tangent_line(v, t1, r, xoff2, yoff2);
plot(xt1, yt1, 'b-', xt2, yt2, 'g-');
[xt1, yt1] = mth_circle_tangent_line(v, t2, r, xoff1, yoff1);
[xt2, yt2] = mth_circle_tangent_line(v, t2, r, xoff2, yoff2);
plot(xt1, yt1, 'b-', xt2, yt2, 'g-');

xlabel('x');
ylabel('y');
title('Tangent Lines to Equally Sized Circles');
grid on;
axis equal;
