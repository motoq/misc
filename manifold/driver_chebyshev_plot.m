%
% Plots Chebyshev polynomials of the first and second kinds, T0 through T5
%
% Kurt Motekew  2025/03/15
%

clear;

  % Note Legends below is hard coded to this number
order = 5;

xx = (-1:.01:1)';
n = size(xx,1);

%
% First kind
%

yy = zeros(n,order+1);
for ii = 1:n
    % One column per order
    % Each row for a different value of x from [-1, 1]
  yy(ii,:) = mth_tpoly(order, xx(ii));
end

figure;  hold on;
plot(xx, yy);
title('Chebyshev Polynomials of the First Kind');
legend('T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'Location', 'SouthEast');
grid on;
axis equal;

%
% Second kind
%

yy = zeros(n,order+1);
for ii = 1:n
    % One column per order
    % Each row for a different value of x from [-1, 1]
  yy(ii,:) = mth_upoly(order, xx(ii));
end

figure;  hold on;
plot(xx, yy);
title('Chebyshev Polynomials of the Second Kind');
legend('T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'Location', 'SouthEast');
grid on;
