%
% Illustrate generating coordinates for a vector given basis vectors
% that are neither orthonormal nor orthogonal.  A set of covariant basis
% vectors are generated based on the definition of an oblate spheroidal
% coordinate system.  The contravariant vector components are solved for
% allowing a vector (r0) to be defined as a linear combination of scale
% factors.  Contravariant basis vectors are generated from the covariant
% ones, and r0 is once again recreated using covariant vector
% components.
%
% Covariance is represented by an underscore (subscript):  e_1
% Contravariance is represented without the underscore:    e1
%
% See Section 2.4 of Pavel Grinfeld's "An Introduction to Tensor
% Calculus":
%
% <https://grinfeld.org/books/An-Introduction-To-Tensor-Calculus/Chapter1.html>
%
% Kurt Motekew
% 2024/02/14
%

clear;
close all;

  % Vector defined in Cartesian space for which to find components
  % with the new basis vectors
r0 = [-1 ; -1 ; 1];

  % Use the oblate spheroidal system to generate basis vectors
  % (just for convenience)
e = .9;                                          % Shape
a = 3.75;                                        % Semimajor axis length, units
lambda = pi*75/180;                              % Azimuth range
eta = 0.9;                                       % Elevation range

  % Covariant basis vectors
[e_1, e_2, e_3] = mth_os_cov_basis(e, a, lambda, eta);

  % Generate contravariant metric tensor from covariant
  % to illustrate relationship (vs. direct formulation of
  % contravariant metric tensor or backwards substitution
  % with covariant metric tensor).
  %
  % Covariant metric tensor from basis vectors
g_ij = [e_1'*e_1 , e_1'*e_2 , e_1'*e_3 ;
        e_2'*e_1 , e_2'*e_2 , e_2'*e_3 ;
        e_3'*e_1 , e_3'*e_2 , e_3'*e_3 ];
  % Contravariant metric tensor is the inverse
gij = g_ij^-1;

  % Dot each basis vector with r0 and transform
  % to get contravariant vector components
coeff = gij*[e_1'*r0 ; e_2'*r0 ; e_3'*r0];

% Alternate 1:  Use direct formulation of the contravariant
%               metric tensor
%gij = mth_os_mt_cont(e, a, eta);
%
% Alternate 2:  Start with covariant metric tensor, but use
%               decomposition and backwards substitutoin (Bierman
%               project) to avoid a solution via matrix inversion
%[Q, R] = qr(g_ij);
%y = [e_1'*r0 ; e_2'*r0 ; e_3'*r0];
%coeff = mth_trisol(R, Q'*y);

  % Vector components on individual covariant basis vectors
x1 = coeff(1)*e_1;
x2 = coeff(2)*e_2;
x3 = coeff(3)*e_3;

  % Reconstructed vector in Cartesian space
r1 = x1 + x2 + x3;

  % Repeat representation and reconstruction using contravariant
  % basis vectors.  Start by forming contravariant basis vectors via
  % index raising
e1 = gij(1,1)*e_1 + gij(1,2)*e_2 + gij(1,3)*e_3;
e2 = gij(2,1)*e_1 + gij(2,2)*e_2 + gij(2,3)*e_3;
e3 = gij(3,1)*e_1 + gij(3,2)*e_2 + gij(3,3)*e_3;
  % Create a linear combination of the contravariant basis vectors
  % to reconstruct the original vector
coeff = g_ij*[e1'*r0 ; e2'*r0 ; e3'*r0];
x_1 = coeff(1)*e1;
x_2 = coeff(2)*e2;
x_3 = coeff(3)*e3;
r2 = x_1 + x_2 + x_3;

  % Plot using covariant basis vectors
figure;  hold on;
  % Basis vectors
quiver3(0, 0, 0, e_1(1), e_1(2), e_1(3),...
        'color',[1,0,0],'linewidth',1, 'AutoScale', 'off');
quiver3(0, 0, 0, e_2(1), e_2(2), e_2(3),...
        'color',[0,1,0],'linewidth',1, 'AutoScale', 'off');
quiver3(0, 0, 0, e_3(1), e_3(2), e_3(3),...
        'color',[0,0,1],'linewidth',1, 'AutoScale', 'off');
  % Original vector
quiver3(0, 0, 0, r0(1), r0(2), r0(3),...
        'color',[0,0,0],'linewidth',2, 'AutoScale', 'off');
  % Components on new basis vectors
plot3([r0(1) x1(1)], [r0(2) x1(2)], [r0(3) x1(3)], '-k');
scatter3(x1(1), x1(2), x1(3), 40, 0.0, 'filled');
plot3([r0(1) x2(1)], [r0(2) x2(2)], [r0(3) x2(3)], '-k');
scatter3(x2(1), x2(2), x2(3), 40, 0.0, 'filled');
plot3([r0(1) x3(1)], [r0(2) x3(2)], [r0(3) x3(3)], '-k');
scatter3(x3(1), x3(2), x3(3), 40, 0.0, 'filled');
xlabel('x');
ylabel('y');
zlabel('z');
title('Using Covariant Basis Vectors');
axis equal;

  % Plot using contravariant basis vectors
figure;  hold on;
  % Basis vectors
quiver3(0, 0, 0, e1(1), e1(2), e1(3),...
        'color',[1,0,0],'linewidth',1, 'AutoScale', 'off');
quiver3(0, 0, 0, e2(1), e2(2), e2(3),...
        'color',[0,1,0],'linewidth',1, 'AutoScale', 'off');
quiver3(0, 0, 0, e3(1), e3(2), e3(3),...
        'color',[0,0,1],'linewidth',1, 'AutoScale', 'off');
  % Original vector
quiver3(0, 0, 0, r0(1), r0(2), r0(3),...
        'color',[0,0,0],'linewidth',2, 'AutoScale', 'off');
  % Components on new basis vectors
plot3([r0(1) x_1(1)], [r0(2) x_1(2)], [r0(3) x_1(3)], '-k');
scatter3(x_1(1), x_1(2), x_1(3), 40, 0.0, 'filled');
plot3([r0(1) x_2(1)], [r0(2) x_2(2)], [r0(3) x_2(3)], '-k');
scatter3(x_2(1), x_2(2), x_2(3), 40, 0.0, 'filled');
plot3([r0(1) x_3(1)], [r0(2) x_3(2)], [r0(3) x_3(3)], '-k');
scatter3(x_3(1), x_3(2), x_3(3), 40, 0.0, 'filled');
xlabel('x');
ylabel('y');
zlabel('z');
title('Using Contravariant Basis Vectors');
axis equal;

  % Output
fprintf('\ne_1 dot e1: %1.3e', e1'*e_1);
fprintf('\ne_2 dot e2: %1.3e', e2'*e_2);
fprintf('\ne_3 dot e3: %1.3e', e3'*e_3);
fprintf('\ne_1 dot e2: %1.3e', e1'*e_2);
fprintf('\ne_1 dot e3: %1.3e', e1'*e_3);
fprintf('\ne_2 dot e3: %1.3e', e2'*e_3);
fprintf('\nThe difference between the original and new vector is %1.3e',...
         norm(r0 - r1));
fprintf('\nThe difference between the original and new vector is %1.3e',...
         norm(r0 - r2));

fprintf('\n');
