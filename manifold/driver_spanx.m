% Use QR decomposition to determine the intersection of two planes defined by
% the span of two pairs of vectors.
%
% Problem 7.4 from Trefethen & Bau's "Numerical Linear Algebra" with help
% from Yan Zeng's 2009 solution manual.
%

close all;
clear;

  % If true, use "pretty" basis vectors to intersect.  Otherwise, use
  % randomly generated ones.
demo = true;

  % Origin
o = [0 0 0]';

  % x1, y1 span A1
  % x2, y2 span A2
if demo
  x1 = [ 1 2 3]';
  y1 = [ -2 3 5]';
  x2 = [ 0 3 2]';
  y2 = [ -1 -2 3]';
else
    % seems to suck just slighly less than randn alone
  x1 = sign(randn(3,1)).*rand(3,1);
  y1 = sign(randn(3,1)).*rand(3,1);
  x2 = sign(randn(3,1)).*rand(3,1);
  y2 = sign(randn(3,1)).*rand(3,1);
end
  % Cross product to form 3rd subspace and locate intersection
x3 = cross(x1,y1);
y3 = cross(x2,y2);

  % Normalize plotted vectors
x1_hat = x1/norm(x1);
y1_hat = y1/norm(y1);
x2_hat = x2/norm(x2);
y2_hat = y2/norm(y2);
x3_hat = x3/norm(x3);
y3_hat = y3/norm(y3);

  % Locate intersection of planes spanned by A1 and A2
A3 = [x3 y3];
[Q3, R3] = qr(A3);
  % x3 and y3 are scalar mutiples of corresponding q3 vectors
% x3 ./ Q1(:,3);
% y3 ./ Q2(:,3);
v = cross(Q3(:,1),Q3(:,2));
v_hat = v/norm(v);

  % Plot
figure;  hold on;
quiver3(o(1), o(2), o(3), x1_hat(1), x1_hat(2), x1_hat(3),...
                         'color', [0, 0, 1], 'linewidth', 3);
quiver3(o(1), o(2), o(3), y1_hat(1), y1_hat(2), y1_hat(3),...
                         'color', [0, 0, 1], 'linewidth', 3);
quiver3(o(1), o(2), o(3), x2_hat(1), x2_hat(2), x2_hat(3),...
                         'color', [0, 1, 0], 'linewidth', 3);
quiver3(o(1), o(2), o(3), y2_hat(1), y2_hat(2), y2_hat(3),...
                         'color', [0, 1, 0], 'linewidth', 3);
quiver3(o(1), o(2), o(3), v_hat(1), v_hat(2), v_hat(3),...
                         'color', [0, 0, 0], 'linewidth', 3);
title('Intersection of Span of Blue and Span of Green');
xlabel('x');
ylabel('y');
zlabel('z');

axis equal;
