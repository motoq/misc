%
% Illustrates polynomial fits to the Runge example (or half of an
% ellipse) through Lagrange polynomials with equal and Chebychev node
% spacing.  A fit using a Chebyshev polynomial is also generated, and
% the condition number of the associated information matrix for all
% fits is generated.
%
% The sample functions are are designed to be generated on a range of
% [-1, 1].  No normalization of the independent parameter
% (shifting/scaling) is performed for this example.
%
% Kurt Motekew  2025/03/15
%

%

close all;
clear;

  % Top part of an ellipse
%f = @(x) 0.5*sqrt(1 - x.*x);
  % Runge example
f = @(x) 1./(1 + 25*x.*x);

  % True function values (lots of points to capture ellipse shape
  % for when that function is chosen)
x = [-1:.001:1]';
y = f(x);

%
% Lagrange polynomial
%

  % Equal spacing polynomial nodes - order will be one less than the number
  % of fit points resulting in a polynomial passing through each point
xo = [-1:.2:1]';
yo = f(xo);
  % Number of nodes and polynomial order
n = size(xo,1);
order = n-1;

  % Vandermonde Matrix using equally spaced nodes
A = zeros(n);
A(:,1) = ones(size(xo));
for ii = 2:n
  A(:,ii) = xo.*A(:,ii-1);
end
  % Information matrix - output condition with plot
  % Solve using matrix inversion for illustrative purposes
  % vs. proper matrix decomposition and backwards substitution
F = (A'*A);
p = F^-1*A'*yo;
yp = zeros(size(x));
for ii = 1:n 
  yp = yp + p(ii)*x.^(ii-1);
end

figure;  hold on;
plot(x, y, '-k');
plot(xo, yo, 'ob');
plot(x, yp, '-r');
stitle = sprintf('%ith Order Lagrange Equal Spacing cond(A''A) = %1.1f',...
                 order, cond(F));
title(stitle);
axis equal;

%
% Lagrange polynomial with Chebyshev node spacing
%

  % Compute new fit points, but keep order and fit method the same
k = [1:n]';
xo = cos(0.5*pi*(2*k-1)/n);
yo = f(xo);

  % Vandermonde Matrix using Chebyshev node spacing
A = zeros(n);
A(:,1) = ones(size(xo));
for ii = 2:n
  A(:,ii) = xo.*A(:,ii-1);
end
F = (A'*A);
p = F^-1*A'*yo;
yp = zeros(size(x));
for ii = 1:n 
  yp = yp + p(ii)*x.^(ii-1);
end

figure;  hold on;
plot(x, y, '-k');
plot(xo, yo, 'ob');
plot(x, yp, '-r');
stitle = sprintf('%ith Order Lagrange Chebyshev Spacing cond(A''A) = %1.1f',...
                 order, cond(F));
title(stitle);
axis equal;

%
% Chebyshev polynomial
%

  % Repeat generation of Chebyshev nodes for convenience of reference
k = [1:n]';
xo = cos(0.5*pi*(2*k-1)/n);
yo = f(xo);
  % Fit using Chebyshev polynomials
T = zeros(n, order+1);
for ii = 1:n
  T(ii,:) = mth_tpoly(order, xo(ii));
end
F = (T'*T);
C = F^-1;
pt = C*T'*yo;
yt = zeros(size(x));
for ii = 1:n 
  yt = yt + T(ii)*pt(ii);
end

figure;  hold on;
plot(x, y, '-k');
plot(xo, yo, 'ob');
plot(x, yp, '-r');
stitle = sprintf('%ith Order Chebyshev cond(T''T) = %1.1f', order, cond(F));
title(stitle);
axis equal;

fprintf('\n');

