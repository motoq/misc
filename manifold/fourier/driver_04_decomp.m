%
% Define a composite signal given multiple sinusoids then extract the
% sinusoids via Fourier transform.  The assumed base frequency can be
% subject to a fixed bias.
%
% Kurt Motekew  2022/08/05
%

clear;

w1 = 2.0e9;
  % Assumed base frequency bias for reconstruction
dw = 100e6;

  % Define sinusoids composing the signal using more human readable
  % polar format
a0 = 3;
  % Component sinusoids
ai = [2 3 4];
phii = pi*[30 60 120]/180;

  % Fraction of period for time increment
frac_pd = .02;

  %
  % End user inputs
  %

  % Period and increment
pd = 2*pi/w1;
dt = frac_pd*pd;
t = (-pd/2):dt:(pd/2);
nt = size(t,2);
  % Number of component sinusoids
ncs = size(ai,2);

fprintf('\nFundamental frequency %1.1e Hz', w1);
fprintf(' and Period %1.3e sec', pd);
fprintf('\nError in Assumed Base Frequency During Reconstruction is');
fprintf(' %1.1e Hz', dw);

  % harmonic frequencies of component sinusoids
ni = 1:ncs;
wi = ni*w1;

  % Plot truth values
figure; hold on;
y = zeros(1,nt);
yi = zeros(ncs,nt);
for ii = 1:ncs
  yi(ii,:) = ai(ii)*cos(wi(ii)*t - phii(ii));
  y = y + yi(ii,:);
  plot(t, yi(ii,:));
end
y = y + a0/2;
plot(t, y, 'linewidth',3);

  % Extract components based on potentially biased base frequency
ai_hat = zeros(size(ai));
phii_hat = zeros(size(ai));
ci_hat = zeros(size(ai));
di_hat = zeros(size(ai));
yi_hat = zeros(size(ai));
wi_hat = dw + ni*w1;
c0_hat = (2.0/pd)*trapz(t, y);
a0_hat = c0_hat;
for ii = 1:ncs
  ci_hat(ii) = (2.0/pd)*trapz(t, yi(ii,:).*cos(wi_hat(ii)*t));
  di_hat(ii) = (2.0/pd)*trapz(t, yi(ii,:).*sin(wi_hat(ii)*t));
  [ai_hat(ii), phii_hat(ii)] = sig_cart2polar(ci_hat(ii), di_hat(ii));
end

  % Check error in solution
fprintf('\ndA0: %1.1e,  ||dAn||: %1.1e,  ||dPhin||: %1.1e',...
         abs(a0 - a0_hat), norm(ai - ai_hat), norm(phii - phii_hat));
  % Plot estimated composite signal
y_hat = zeros(size(y));
for ii = 1:ncs
  y_hat = y_hat + ci_hat(ii)*cos(wi_hat(ii)*t) + di_hat(ii)*sin(wi_hat(ii)*t);
end
y_hat = y_hat + c0_hat/2;
plot(t, y_hat, '+');
stitle = sprintf('%1.1e Hz with Base Frequency Bias %1.1e Hz', w1, dw);
title(stitle);

fprintf('\n');
