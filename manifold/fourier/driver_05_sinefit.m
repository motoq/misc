%
% Demonstrates determining the coefficients of a single sinusoid with
% known frequency:
%
% (w,t) = C0/2 + C*cos(wt) + D*sin(wt)
%
% The continuous form of the function is used to generate discrete
% points on the sinusoid at a given frequency.  The coefficients are
% solved for over a range of frequencies.  Each result is compared to
% the discrete points.  The best match is chosen to represent the
% sinusoid.
%
% Kurt Motekew  2023/06/22
%

clear;

  % Fundamental Frequency as rad/sec
w1 = 1.0;

  % Coefficients of the sinusoid function
c0 = 3;
c1 = 2.5;
d1 = 3.7; 

  % Fraction of period for time increment between discrete points
frac_pd = .02;
  % Frequency search interval
dw = 0.1;

%
% End user inputs
%

  % Period and increment given frequency in rad/sec
pd = 2*pi/w1;
dt = frac_pd*pd;
t = (-pd/2):dt:(pd/2);

  % Truth values to fit to
y1 = c0/2 + c1*cos(w1*t) + d1*sin(w1*t);

  % Shift in range is frequency independent
c0_hat = (2.0/pd)*trapz(t, y1);

  % Solve for c1 and d1 by brute force iterating through frequencies wn
  % Use a simple cost function to find best fit
cf = norm(y1);
wn = 0;
w1_hat = wn;
for wn = 0:dw:(2*w1)
  cn_hat = (2.0/pd)*trapz(t, y1.*cos(wn*t));
  dn_hat = (2.0/pd)*trapz(t, y1.*sin(wn*t));
  yn_hat = c0_hat/2 + cn_hat*cos(wn*t) + dn_hat*sin(wn*t);
  cfnow = norm(yn_hat - y1);
  if cfnow < cf
    cf = cfnow;
    w1_hat = wn;
    c1_hat = cn_hat;
    d1_hat = dn_hat;
  end
end

  % Reconstructed sinusoid
y1_hat = c0_hat/2 + c1_hat*cos(w1_hat*t) + d1_hat*sin(w1_hat*t);

figure; hold on;
stitle = sprintf('y = %1.1fcos(%1.1ft) + %1.1fsin(%1.1ft)', c1, w1, d1, w1);
xlabel('t');
ylabel('y');
title(stitle);
plot(t, y1_hat, 'k', 'LineWidth', 2);
plot(t, y1, 'o');
grid on;

fprintf('\nTruth Values:');
fprintf('\n  Frequency %1.1f rad/sec', w1);
fprintf('\n  C0 = %1.1f  C1 = %1.1f  D1 = %1.1f', c0, c1, d1);
fprintf('\nEstimated Values:');
fprintf('\n  Frequency %1.1f rad/sec', w1_hat);
fprintf('\n  C0 = %1.1f  C1 = %1.1f  D1 = %1.1f', c0_hat, c1_hat, d1_hat);

fprintf('\n');
