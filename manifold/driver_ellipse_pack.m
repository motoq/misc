close all;
clear;

%
% Demonstrates packing and overlapping without gaps equal sized ellipses
%
% Kurt Motekew  2022/09/08
%

  % Packing or no gap overlay
pack = 0;
nogap = 1;
fit = nogap*pi/6;

  % Ellipse definition
Cov = [3 2 ; 2 4];
[V, L] = eig(Cov);
ehat_1 = V(:,1);
ehat_2 = V(:,2);
e_1 = sqrt(L(1,1))*ehat_1;
e_2 = sqrt(L(2,2))*ehat_2;

  % Rotation then axis scaling
C = [ehat_1' ; ehat_2'];
T = [1/sqrt(L(1,1)) 0 ; 0 1/sqrt(L(2,2))];
Tac = T*C;
Tca = Tac^-1;

  % Circular ellipse after affine transformation
CovA = Tac*Cov*Tac';

  % Optimal circle packing at 60 deg increments about reference axis
  % Compute x and y component of circle (and ellipse) origins
nc = 7;
r = zeros(2,nc);
ra = zeros(2,nc);
theta = 0;
for ii = 1:(nc-1)
  ra(:,ii) = 2*cos(fit)*[cos(theta) ; sin(theta)];
  r(:,ii) = Tca*ra(:,ii);
  theta = theta + pi/3;
end

  % Plot ellipse definition with axes
figure; hold on;
[smajor, sminor, orient] = mth_cov2ellipse_eig(Cov);
[xvals, yvals] = mth_ellipse(0, 0, smajor, sminor, orient, 30);
plot(xvals, yvals, 'k');
quiver(0, 0, e_1(1), e_1(2), 'color', [1 0 0], 'linewidth', 1,...
                                               'AutoScale','off');
quiver(0, 0, e_2(1), e_2(2), 'color', [0 1 0], 'linewidth', 1,...
                                               'AutoScale','off');
xlabel('x');
ylabel('y');
title('Ellipse to Pack');
axis equal;

  % Plot packed circles
figure; hold on;
[smajor, sminor, orient] = mth_cov2ellipse_eig(CovA);
[xvals, yvals] = mth_ellipse(0, 0, smajor, sminor, orient, 30);
plot(xvals, yvals, 'k');
for ii = 1:nc
  [xvals, yvals] = mth_ellipse(ra(1,ii), ra(2,ii), smajor, sminor, orient, 30);
  plot(xvals, yvals, 'k');
end
xlabel('x');
ylabel('y');
title('Packed Unit Circles');
axis equal;

  % Plot packed ellipses
figure; hold on;
[smajor, sminor, orient] = mth_cov2ellipse_eig(Cov);
[xvals, yvals] = mth_ellipse(0, 0, smajor, sminor, orient, 30);
plot(xvals, yvals, 'k');
for ii = 1:nc
  [xvals, yvals] = mth_ellipse(r(1,ii), r(2,ii), smajor, sminor, orient, 30);
  plot(xvals, yvals, 'k');
end
xlabel('x');
ylabel('y');
title('Packed Unit Ellipses');
axis equal;
