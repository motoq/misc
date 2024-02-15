%
% Illustrate generating coordinates for a vector given basis vectors
% that are neither orthonormal nor orthogonal
%
% See Section 2.4 of Pavel Grinfeld's "An Introduction to Tensor
% Calculus":
%
% <https://grinfeld.org/books/An-Introduction-To-Tensor-Calculus/Chapter2.html>
%
% Kurt Motekew
% 2024/02/14
%

clear;
close all;

  % Use the oblate spheroidal system to generate basis vectors
  % (just for convenience)
e = .9;                                          % Shape
a = 3.75;                                        % Semimajor axis length, units
lambda = pi*75/180;                              % Azimuth range
eta = 0.9;                                       % Elevation range

  % Vector defined in Cartesian space for which to find components
  % with the new basis vectors
r = [-1 ; -1 ; 1];

  % Covariant basis vectors
[e_1, e_2, e_3] = mth_os_cov_basis(e, a, lambda, eta);

  % Generate contravariant metric tensor from covariant
  % to illustrate relationship (vs. direct solution of
  % contravariant metric tensor or backwards substitution
  % with covariant metric tensor).
  %
  % Covariant metric tensor
g_ij = [e_1'*e_1 , e_1'*e_2 , e_1'*e_3 ;
        e_2'*e_1 , e_2'*e_2 , e_2'*e_3 ;
        e_3'*e_1 , e_3'*e_2 , e_3'*e_3 ];
  % Contravariant metric tensor is the inverse
gij = g_ij^-1;
  % Dot each basis vector with r and transform
ui = gij*[e_1'*r ; e_2'*r ; e_3'*r];

% Alternate 1:  Use direct solution to contravariant metric tensor
%gij = mth_os_mt_cont(e, a, eta);
%
% Alternate 2:  Avoid inversion of covariant metric tensor
%[Q, R] = qr(g_ij);
%y = [e_1'*r ; e_2'*r ; e_3'*r];
%ui = mth_trisol(R, Q'*y);

  % Vector components on individual covariant basis vectors
x1 = ui(1)*e_1;
x2 = ui(2)*e_2;
x3 = ui(3)*e_3;

  % Reconstructed vector in Cartesian space
r2 = x1 + x2 + x3;

  % Plot
figure;  hold on;
  % Basis vectors
quiver3(0, 0, 0, e_1(1), e_1(2), e_1(3),...
        'color',[1,0,0],'linewidth',1, 'AutoScale', 'off');
quiver3(0, 0, 0, e_2(1), e_2(2), e_2(3),...
        'color',[0,1,0],'linewidth',1, 'AutoScale', 'off');
quiver3(0, 0, 0, e_3(1), e_3(2), e_3(3),...
        'color',[0,0,1],'linewidth',1, 'AutoScale', 'off');
  % Original vector
quiver3(0, 0, 0, r(1), r(2), r(3),...
        'color',[0,0,0],'linewidth',2, 'AutoScale', 'off');
  % Components on new basis vectors
plot3([r(1) x1(1)], [r(2) x1(2)], [r(3) x1(3)], '-k');
scatter3(x1(1), x1(2), x1(3), 40, 0.0, 'filled');
plot3([r(1) x2(1)], [r(2) x2(2)], [r(3) x2(3)], '-k');
scatter3(x2(1), x2(2), x2(3), 40, 0.0, 'filled');
plot3([r(1) x3(1)], [r(2) x3(2)], [r(3) x3(3)], '-k');
scatter3(x3(1), x3(2), x3(3), 40, 0.0, 'filled');
xlabel('x');
ylabel('y');
zlabel('z');
axis equal;

  % Output
fprintf('\nThe difference between the original and new vector is %1.3e',...
         norm(r - r2));

fprintf('\n');
