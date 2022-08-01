%
% Demonstrates determining the coefficients of a single sinusoid with
% known frequency:
%
% (w,t) = C*cos(wt) + D*sin(wt)
%
% First, the continuous form of the function is used to solve for the
% coefficients (through the use of numeric integration).  Next, discrete
% points are used.  Finally, discrete points, at values subject to noise
% and/or bias are used.
%
% Kurt Motekew  2022/07/31
%

close all;
clear;

  % Frequency, Hz
w1 = 1.0;

  % Coefficients of the sinusoid function: y(w,t) = C*cos(wt) + D*sin(wt)
  %                                               = A*cos(wt - phi)
c1 = 2.5;
d1 = 3.7; 

  % Mean and standard deviation of noise to be applied
mu = 0.0;
sigma = 0.1;

%
% End user inputs
%

  % In terms of amplitude and phase offset
a1 = sqrt(c1*c1 + d1*d1);
phi1 = atan2(d1,c1);

  % Period and increment
pd = 2*pi/w1;
dt = pd/100;
t = 0:dt:pd;

  % Truth
y1 = c1*cos(w1*t) + d1*sin(w1*t);
  % Noisy
y1_n = (mu + sigma*randn(1,size(y1,2))) + y1;

fprintf('\nFrequency %1.1f Hz', w1);
fprintf('\nPeriod %1.3e sec', pd);
fprintf('\nAmplitude %1.1f', a1);
fprintf('\nPhase %1.2f deg', 180*phi1/pi);
fprintf('\n');

figure; hold on;
plot(t, y1);
plot(t, a1*cos(w1*t - phi1));
plot(t, y1_n, '*');

%
% Determine coeffcients by integrating the sine wave definition
%

fun = @(t) (c1*cos(w1*t) + d1*sin(w1*t)).*cos(w1*t);
c1_hat = (2.0/pd)*integral(fun,0,pd);
fun = @(t) (c1*cos(w1*t) + d1*sin(w1*t)).*sin(w1*t);
d1_hat = (2.0/pd)*integral(fun,0,pd);

fprintf('\nDetermination using f(wt)');
fprintf('\nc1: %1.3f  vs.  c1: %1.3f', c1, c1_hat);
fprintf('\nd1: %1.3f  vs.  d1: %1.3f', d1, d1_hat);

%
% Determine coeffcients by integrating discrete points 
%

c1_hat = (2.0/pd)*trapz(t, y1.*cos(w1*t));
d1_hat = (2.0/pd)*trapz(t, y1.*sin(w1*t));

fprintf('\nDetermination using f[wt] with dt = %1.1e sec', dt);
fprintf('\nc1: %1.3f  vs.  c1: %1.3f', c1, c1_hat);
fprintf('\nd1: %1.3f  vs.  d1: %1.3f', d1, d1_hat);

%
% Determine coeffcients by integrating discrete points subject to
% noise and bias
%

c1_hat = (2.0/pd)*trapz(t, y1_n.*cos(w1*t));
d1_hat = (2.0/pd)*trapz(t, y1_n.*sin(w1*t));

fprintf('\nDetermination using f[wt] + N(%1.1f,%1.1f)', mu, sigma);
fprintf('\nc1: %1.3f  vs.  c1: %1.3f', c1, c1_hat);
fprintf('\nd1: %1.3f  vs.  d1: %1.3f', d1, d1_hat);

stitle = sprintf('y = %1.1fcos(%1.1ft) + %1.1fsin(%1.1ft)', c1, w1, d1, w1);
xlabel('t');
ylabel('y');
title(stitle);

fprintf('\n');
