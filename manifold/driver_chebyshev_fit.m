%
% Illustrates polynomial fits to the Runge example (or half of an
% ellipse) through Lagrange polynomials with equal and Chebychev node
% spacing.  Fits using Chebyshev polynomials of the first and second
% kinds are generated, and the condition number of the associated
% information matrix for all are generated.  Barycentric Lagrange
% interpolation is also illustrated.
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
  % Berrut/Trefethen example
%f = @(x) abs(x) + x/2.0 - x.*x;
  % Runge example
f = @(x) 1./(1 + 25*x.*x);

  % True function values (lots of points to capture ellipse shape
  % for when that function is chosen)
xx = (-1:.001:1)';
yy = f(xx);

%
% Lagrange polynomial
%

  % Equal spacing polynomial nodes - order will be one less than the number
  % of fit points resulting in a polynomial passing through each point
xo = (-1:.2:1)';
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
yp = zeros(size(xx));
for ii = 1:n 
  yp = yp + p(ii)*xx.^(ii-1);
end

figure;  hold on;
plot(xx, yy, '-k');
plot(xo, yo, 'ob');
plot(xx, yp, '-r');
stitle = sprintf('%ith Order Lagrange Equal Spacing cond(A''A) = %1.1f',...
                 order, cond(F));
title(stitle);
axis equal;

%
% Lagrange polynomial with Chebyshev node spacing
%

  % Compute new fit points, but keep order and fit method the same
%kk = [1:n]';
%xo = cos(0.5*pi*(2*kk-1)/n);                % 1st kind
xo = -cos(pi*(0:order)'/order);             % 2nd kind
yo = f(xo);

  % Vandermonde Matrix using Chebyshev node spacing
A = zeros(n);
A(:,1) = ones(size(xo));
for ii = 2:n
  A(:,ii) = xo.*A(:,ii-1);
end
F = (A'*A);
p = F^-1*A'*yo;
yp = zeros(size(xx));
for ii = 1:n 
  yp = yp + p(ii)*xx.^(ii-1);
end

figure;  hold on;
plot(xx, yy, '-k');
plot(xo, yo, 'ob');
plot(xx, yp, '-r');
stitle = sprintf('%ith Order Lagrange Chebyshev Spacing cond(A''A) = %1.1f',...
                 order, cond(F));
title(stitle);
axis equal;

%
% Chebyshev polynomial.  Using Chebyshev points of the 2nd kind instead
% of the 1st kind slightly increases the cond() number of the
% information matrix.  But, the end nodes match +/-1 without numerical
% roundoff and there is less Runge effect at the endpoints.
%

  % Chebyshev points - repeat for convenience of reference
%kk = [1:n]';
%xo = cos(0.5*pi*(2*kk-1)/n);                % 1st kind
xo = -cos(pi*(0:order)'/order);             % 2nd kind
yo = f(xo);
  % Fit using Chebyshev polynomials
T = zeros(n, order+1);
for ii = 1:n
  T(ii,:) = mth_tpoly(order, xo(ii));
end
F = (T'*T);
C = F^-1;
pt = C*T'*yo;
yt = zeros(size(xx));
for ii = 1:size(xx,1) 
  yt(ii) = mth_tpoly(order, xx(ii))*pt;     % Should vectorize mth_tpoly...
end

figure;  hold on;
plot(xx, yy, '-k');
plot(xo, yo, 'ob');
plot(xx, yt, '-r');
stitle = sprintf('%ith Order Chebyshev cond(T''T) = %1.1f', order, cond(F));
title(stitle);
axis equal;

%
% Chebyshev polynomial of the 2nd kind
%

  % Chebyshev points of the 2nd
xo = -cos(pi*(0:order)'/order);
yo = f(xo);
U = zeros(n, order+1);
for ii = 1:n
  U(ii,:) = mth_upoly(order, xo(ii));
end
F = (U'*U);
C = F^-1;
pu = C*U'*yo;
yu = zeros(size(xx));
for ii = 1:size(xx,1) 
  yu(ii) = mth_upoly(order, xx(ii))*pu;
end

figure;  hold on;
plot(xx, yy, '-k');
plot(xo, yo, 'ob');
plot(xx, yu, '-r');
stitle = sprintf('%ith Order Chebyshev 2nd kind cond(U''U) = %1.1f',...
                  order, cond(F));
title(stitle);
axis equal;

%
% Barycentric interpolation
%
% From:  Jean-Paul Berrut and Lloyd N. Trefethen,
%        Barycentric Lagrange Interpolation,
%        SIAM Review Vol. 46. No. 3. pp 501-517
%        2004 Society for Industrial and Applied Mathematics
%
% Real World Implementation Notes:
%   - When computing cc, instead of (-1)^jj to compute sign, implement
%     via mod 2.  The current implementation is handy with vectorization.
%   - Divide by zero logic should be expanded to handle near zero.
%     It works fine here, but for real world interpolation, we are
%     typically arbitrarily close to the first node for many problems.
%     In practice, additional logic needs to be added to map node
%     points to divide by zero locations vs. pulling true value
%     from a function that is continuous over the range of interest
%     since the point of interpolation is not having the function on
%     hand in the first place.
%   - The size of "exact" can change with each loop - update bookeeping
%     method for a production implementation.
%

  % Chebyshev points of the 2nd kind
xo = -cos(pi*(0:order)'/order);
yo = f(xo);
  % [.5 ; -1 ; 1 ... 1 ; -1 .5]'
cc = [1/2 ; ones(order-1,1) ; 1/2].*(-1).^((0:order)');
numer = zeros(size(xx));
denom = zeros(size(xx));
for jj = 1:n
  xdiff = xx - xo(jj);
  temp = cc(jj)./xdiff;
  numer = numer + temp*yo(jj);
  denom = denom + temp;
  exact(xdiff == 0) = 1;                    % Don't divide by 0
end
yb = numer./denom;
  % Use node point to cover divide by 0
ii = find(exact);
yb(ii) = yy(exact(ii));

figure;  hold on;
plot(xx, yy, '-k');
plot(xo, yo, 'ob');
plot(xx, yb, '-r');
stitle = sprintf('%ith Order Barycentric', order);
title(stitle);
axis equal;

fprintf('\n');

