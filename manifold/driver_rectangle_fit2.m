close all;
clear;

%
% Inscribing a rectangle not aligned with an ellipse's principal axes (see
% driver_rectangle_fit.m) via an affine transform, taking advantage of
% the preservation of parallel lines.
%
% Kurt Motekew  2023/04/26
%

  % Ellipse definition
Cov = [3 2 ; 2 4];
[V, L] = eig(Cov);
ehat_1 = V(:,1);
ehat_2 = V(:,2);
e_1 = sqrt(L(1,1))*ehat_1;
e_2 = sqrt(L(2,2))*ehat_2;
  % Project covariance to axes for X and Y axis intercepts
xicpt = sqrt(Cov(1,1));
yicpt = sqrt(Cov(2,2));
  % Circumscribing rectangle - 5 points to close plot
signs = [1, -1, -1,  1, 1 ;
         1,  1, -1, -1, 1 ];
cir_rect(1,:) = xicpt*signs(1,:);
cir_rect(2,:) = yicpt*signs(2,:);

  % Rotation then axis scaling
C = [ehat_1' ; ehat_2'];
T = [1/sqrt(L(1,1)) 0 ; 0 1/sqrt(L(2,2))];
Tac = T*C;
Tca = Tac^-1;
  % Unit circle - rectangle becomes a rhombus
CovA = Tac*Cov*Tac';
cir_rectA = Tac*cir_rect;
  % Find the further vertex
if norm(cir_rectA(:,1)) > norm(cir_rectA(:,2))
  cpA = cir_rectA(:,1);
else
  cpA = cir_rectA(:,2);
end
  % Move the more distant vertext onto the unit curcle
cpA = cpA/norm(cpA);
  % Back to Cartesian space
cp = Tca*cpA;
  % A single corner of the rectangle defines the inscribed rectangle
r = zeros(size(signs));
r(:,1) = cp;
r(:,3) = -cp;
r(:,2) = [-r(1,1) ; r(2,1)];
r(:,4) = -r(:,2);
r(:,size(signs,2)) = r(:,1);

  % For plotting
  % Unit circle after affine transformation
e_1a = Tac*e_1;
e_2a = Tac*e_2;

  % Plot ellipse definition with axes
figure; hold on;
[smajor, sminor, orient] = mth_cov2ellipse_eig(Cov);
[xvals, yvals] = mth_ellipse(0, 0, smajor, sminor, orient, 30);
plot(xvals, yvals, 'k');
quiver(0, 0, e_1(1), e_1(2), 'color', [1 0 0], 'linewidth', 1,...
                                               'AutoScale','off');
quiver(0, 0, e_2(1), e_2(2), 'color', [0 1 0], 'linewidth', 1,...
                                               'AutoScale','off');
plot(cir_rect(1,:), cir_rect(2,:), 'm-');
scatter(cp(1), cp(2), 'm');
plot(r(1,:), r(2,:), 'b-');
scatter(r(1,:), r(2,:), 'b');
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
plot(cir_rectA(1,:), cir_rectA(2,:), 'm-');
scatter(cpA(1), cpA(2), 'b');
xlabel('x');
ylabel('y');
axis equal;
