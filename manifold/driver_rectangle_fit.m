%close all;
clear;

%
% Fixing a maximum area rectangle within an ellipse via an affine
% transform
%
% Kurt Motekew  2023/04/20
%


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

  % Unit circle after affine transformation
CovA = Tac*Cov*Tac';
e_1a = Tac*e_1;
e_2a = Tac*e_2;

  % A square maximizes the area within a circle (proof via area as
  % as a cost function A = cos(theta)*sin(theta), max A at theta = pi/4)
  %
  % Create 5 corners to close plot function (first point = last point)
nc = 5;
r = zeros(2,nc);
ra = zeros(2,nc);
theta = pi/4;
dtheta = pi/2;
for ii = 1:nc
    % Corner of square in unit circle
  ra(:,ii) = [cos(theta) ; sin(theta)];
    % Corresponding corner of rectangle in ellipse
  r(:,ii) = Tca*ra(:,ii);
  theta = theta + dtheta;
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
scatter(r(1,:), r(2,:), 'b');
plot(r(1,:), r(2,:), 'b-');
xlabel('x');
ylabel('y');
axis equal;

  % Plot circle definition with axes
figure; hold on;
[smajor, sminor, orient] = mth_cov2ellipse_eig(CovA);
[xvals, yvals] = mth_ellipse(0, 0, smajor, sminor, orient, 30);
plot(xvals, yvals, 'k');
quiver(0, 0, e_1a(1), e_1a(2), 'color', [1 0 0], 'linewidth', 1,...
                                                 'AutoScale','off');
quiver(0, 0, e_2a(1), e_2a(2), 'color', [0 1 0], 'linewidth', 1,...
                                                 'AutoScale','off');
scatter(ra(1,:), ra(2,:), 'b');
plot(ra(1,:), ra(2,:), 'b-');
xlabel('x');
ylabel('y');
axis equal;
