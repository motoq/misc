close all;
clear;

  % Illustrates two things:
  %   1) Computing the gradient to an ellipse through the gradient of
  %      Mahalanobis distance and the normal to this through the 2D
  %      cross product.  The gradient is normal to the ellipse, and the
  %      cross product, normal to the gradient, is tangent to the
  %      ellipse.
  %   2) Illustrate the tangent remains a tangent to the curve after an
  %      affine transformation.  This tangent can then be used to
  %      compute the normal to the curve through the 2D cross product
  %      with no knowledge of the curve.
  %
  %  Kurt Motekew  2023/05/14
  %

  % Compute points on the unit circle that will be
  % transformed to points on the ellipse
theta = pi*[0:30:360]/180;
ra = [cos(theta) ; sin(theta)];
npts = size(theta,2);

  % Ellipse definition
Cov = [3 2 ; 2 4];
[V, L] = eig(Cov);
ehat_1 = V(:,1);
ehat_2 = V(:,2);
  % Rotation then axis scaling
C = [ehat_1' ; ehat_2'];
T = [1/sqrt(L(1,1)) 0 ; 0 1/sqrt(L(2,2))];
Tac = T*C;
Tca = Tac^-1;
  % Points on ellipse 
r = Tca*ra;

  % Compute gradients and tangents on ellipse in Cartesian space
gr = zeros(2,npts);
gra = gr;
tn = gr;
for ii = 1:npts
  gr(:,ii) = mth_grad_mah(r(:,ii), Cov);
  tn(:,ii) = mth_cross(gr(:,ii));
end
  % Tangents remain valid after an affine transformation
tna = Tac*tn;
  % Normals do not remain valid - compute given tangent and 2D cross product
for ii = 1:npts
  gra(:,ii) = mth_cross(tna(:,ii));
end

  % For plotting
e_1 = sqrt(L(1,1))*ehat_1;
e_2 = sqrt(L(2,2))*ehat_2;
  % Unit circle after affine transformation
CovA = Tac*Cov*Tac';
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
scatter(r(1,:), r(2,:), 'b');
quiver(r(1,:), r(2,:), gr(1,:), gr(2,:), 'color', [0 1 1],...
                                         'linewidth', 1,...
                                         'AutoScale','off');
quiver(r(1,:), r(2,:), tn(1,:), tn(2,:), 'color', [1 0 1],...
                                         'linewidth', 1,...
                                         'AutoScale','off');
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
quiver(ra(1,:), ra(2,:), gra(1,:), gra(2,:), 'color', [0 1 1],...
                                             'linewidth', 1,...
                                             'AutoScale','off');
quiver(ra(1,:), ra(2,:), tna(1,:), tna(2,:), 'color', [1 0 1],...
                                             'linewidth', 1,...
                                             'AutoScale','off');
xlabel('x');
ylabel('y');
axis equal;
