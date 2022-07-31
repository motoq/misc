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
w0 = 1.0;

  % Coefficients of the sinusoid function: y(w,t) = C*cos(wt) + D*sin(wt)
  %                                               = A*cos(wt - phi)
c0 = 2.5;
d0 = 3.7; 

  % Mean and standard deviation of noise to be applied
mu = 0.0;
sigma = 0.1;

%
% End user inputs
%

  % In terms of amplitude and phase offset
a0 = sqrt(c0*c0 + d0*d0);
phi0 = atan2(d0,c0);

  % Period and increment
pd = 2*pi/w0;
dt = pd/100;
t = 0:dt:pd;

  % Truth
y0 = c0*cos(w0*t) + d0*sin(w0*t);
  % Noisy
y0_n = (mu + sigma*randn(1,size(y0,2))) + y0;

fprintf('\nFrequency %1.1f Hz', w0);
fprintf('\nPeriod %1.3e sec', pd);
fprintf('\nAmplitude %1.1f', a0);
fprintf('\nPhase %1.2f deg', 180*phi0/pi);
fprintf('\n');

figure; hold on;
plot(t, y0);
plot(t, a0*cos(w0*t - phi0));
plot(t, y0_n, '*');

%
% Determine coeffcients by integrating the sine wave definition
%

fun = @(t) (c0*cos(w0*t) + d0*sin(w0*t)).*cos(w0*t);
c0_hat = (2.0/pd)*integral(fun,0,pd);
fun = @(t) (c0*cos(w0*t) + d0*sin(w0*t)).*sin(w0*t);
d0_hat = (2.0/pd)*integral(fun,0,pd);

fprintf('\nDetermination using f(wt)');
fprintf('\nc0: %1.3f  vs.  c0: %1.3f', c0, c0_hat);
fprintf('\nd0: %1.3f  vs.  d0: %1.3f', d0, d0_hat);

%
% Determine coeffcients by integrating discrete points 
%

c0_hat = (2.0/pd)*trapz(t, y0.*cos(w0*t));
d0_hat = (2.0/pd)*trapz(t, y0.*sin(w0*t));

fprintf('\nDetermination using f[wt] with dt = %1.1e sec', dt);
fprintf('\nc0: %1.3f  vs.  c0: %1.3f', c0, c0_hat);
fprintf('\nd0: %1.3f  vs.  d0: %1.3f', d0, d0_hat);

%
% Determine coeffcients by integrating discrete points subject to
% noise and bias
%

c0_hat = (2.0/pd)*trapz(t, y0_n.*cos(w0*t));
d0_hat = (2.0/pd)*trapz(t, y0_n.*sin(w0*t));

fprintf('\nDetermination using f[wt] + N(%1.1f,%1.1f)', mu, sigma);
fprintf('\nc0: %1.3f  vs.  c0: %1.3f', c0, c0_hat);
fprintf('\nd0: %1.3f  vs.  d0: %1.3f', d0, d0_hat);

stitle = sprintf('y = %1.1fcos(%1.1ft) + %1.1fsin(%1.1ft)', c0, w0, d0, w0);
xlabel('t');
ylabel('y');
title(stitle);

fprintf('\n');
