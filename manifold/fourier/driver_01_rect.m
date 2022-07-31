%
% Placeholder
%

close all;
clear;

  % Fundamental frequency, Hz
w0 = 1.0;

  % Coefficients of the sinusoid function: y(w,t) = C*cos(wt) + D*sin(wt)
  %                                               = A*cos(wt - phi)
c0 = 2;
d0 = 1;
  % In terms of amplitude and phase offset
a0 = sqrt(c0*c0 + d0*d0);
phi0 = atan2(d0,c0);

%
% End user inputs
%

  % Period and increment
pd = 2*pi/w0;
dt = pd/100;
t = 0:dt:pd;

fprintf('\nFundamental frequency %1.1f Hz', w0);
fprintf('\nPeriod %1.3e sec', pd);
fprintf('\nAmplitude %1.1f', a0);
fprintf('\nPhase %1.2f deg', 180*phi0/pi);
fprintf('\n');

y0 = c0*cos(w0*t) + d0*sin(w0*t);

figure; hold on;
plot(t, y0);

y0 = a0*cos(w0*t - phi0);

plot(t, y0, '*');


