%
% Demonstrates determining the coefficients of a single sinusoid with
% known frequency:
%
% (w,t) = C*cos(wt) + D*sin(wt)
%
% Also, illustrate how the wrong frequency affects the fit.  The first
% plot shows plots of reconstructing the sinusoid using frequencies from
% 0 to w.  The second plot shows w to 2*w.  Note w = 0 and w = 2*w
% result in a flatline due to interger multiples of frequency resulting
% in orthogonal sinusoids.
%
% Kurt Motekew  2023/06/21
%

clear;

  % Frequency as rad/sec
w1 = 1.0;

  % Coefficients of the sinusoid function: y(w,t) = C*cos(wt) + D*sin(wt)
  %                                               = A*cos(wt - phi)
c1 = 2.5;
d1 = 3.7; 

  % Mean and standard deviation of noise to be applied
mu = 0.0;
sigma = 0.1;

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

  % Truth
y1 = c1*cos(w1*t) + d1*sin(w1*t);

fprintf('\nFrequency %1.1f rad/sec', w1);
fprintf('\nPeriod %1.3e sec', pd);
fprintf('\nAmplitude %1.1f', a1);
fprintf('\nPhase %1.2f deg', 180*phi1/pi);
fprintf('\n');


%
% Plot over range of wrong frequencies
%

  % Fit with correct frequency
c1_hat = (2.0/pd)*trapz(t, y1.*cos(w1*t));
d1_hat = (2.0/pd)*trapz(t, y1.*sin(w1*t));
y1_hat = c1_hat*cos(w1*t) + d1_hat*sin(w1*t);

dw = 0.1;

figure; hold on;
for wn = 0:dw:(w1-dw)
  cn_hat = (2.0/pd)*trapz(t, y1.*cos(wn*t));
  dn_hat = (2.0/pd)*trapz(t, y1.*sin(wn*t));
  yn_hat = cn_hat*cos(wn*t) + dn_hat*sin(wn*t);
  plot(t, yn_hat);
end
plot(t, y1_hat, 'k', 'LineWidth', 2);
plot(t, y1, 'o');
stitle = sprintf('y = %1.1fcos(%1.1ft) + %1.1fsin(%1.1ft)', c1, w1, d1, w1);
xlabel('t');
ylabel('y');
title(stitle);
grid on;

figure; hold on;
for wn = (w1-dw):dw:(2.0*w1)
  cn_hat = (2.0/pd)*trapz(t, y1.*cos(wn*t));
  dn_hat = (2.0/pd)*trapz(t, y1.*sin(wn*t));
  yn_hat = cn_hat*cos(wn*t) + dn_hat*sin(wn*t);
  plot(t, yn_hat);
end
plot(t, y1_hat, 'k', 'LineWidth', 2);
plot(t, y1, 'o');
stitle = sprintf('y = %1.1fcos(%1.1ft) + %1.1fsin(%1.1ft)', c1, w1, d1, w1);
xlabel('t');
ylabel('y');
title(stitle);
grid on;

fprintf('\n');
