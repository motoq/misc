%
% Demonstrates determining the coefficients of a single sinusoid with
% known frequency:
%
% (w,t) = C*cos(wt) + D*sin(wt)
%
% Discrete points from the true sinusoid are used to create samples.
% Integration is accomplished through Riemann sums, implemented via
% the dot product.
%
% Kurt Motekew  2023/06/30
%

clear;

  % Frequency as rad/sec
w1 = 1.0;

  % Coefficients of the sinusoid function: y(w,t) = C*cos(wt) + D*sin(wt)
c1 = 2.5;
d1 = 3.7; 

  % Fraction of period for time increment
frac_pd = .02;

%
% End user inputs
%

  % In terms of amplitude and phase offset
[a1, phi1] = sig_rect2polar(c1, d1);

  % Period and increment
pd = 2*pi/w1;
dt = frac_pd*pd;
t1 = -pd/2;
t2 = pd/2;
t = t1:dt:t2;
ns = size(t,2);

  % Truth
y1 = c1*cos(w1*t) + d1*sin(w1*t);

%
% Determine coeffcients by integrating the sine wave definition
% Time drops out for integration via inner product for implementation
% of Riemann sum:
%
% 2/T \int_{-T/2}^{T/2} dt = 2
%

cwave = cos(w1*t);
swave = sin(w1*t);
c1_hat = 2.0*(y1*cwave')/ns;
d1_hat = 2.0*(y1*swave')/ns;

y1_hat = c1_hat*cos(w1*t) + d1_hat*sin(w1*t);

figure; hold on;
plot(t, y1);
plot(t, y1_hat);
stitle = sprintf('y = %1.1fcos(%1.1ft) + %1.1fsin(%1.1ft)', c1, w1, d1, w1);
xlabel('t');
ylabel('y');
title(stitle);

fprintf('\nFrequency %1.1f rad/sec', w1);
fprintf('\nPeriod %1.3e sec', pd);
fprintf('\nAmplitude %1.1f', a1);
fprintf('\nPhase %1.2f deg', 180*phi1/pi);
fprintf('\n');
fprintf('\nTrue vs. Estimated coefficients');
fprintf('\nc1: %1.3f  vs.  c1: %1.3f', c1, c1_hat);
fprintf('\nd1: %1.3f  vs.  d1: %1.3f', d1, d1_hat);

fprintf('\n');
