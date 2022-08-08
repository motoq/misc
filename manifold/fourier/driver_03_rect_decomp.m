%
% Extract sinusoids of known frequency from composite.
%
% % Kurt Motekew  2022/08/03
%

clear;

  % Fundamental frequency as angular rate, rad/sec
w1 = 1.0;

nmax = 5;

  % Period and increment
pd = 2*pi/w1;
dt = pd/100;
t = (-pd/2):dt:(pd/2);

fprintf('\nFundamental frequency %1.1f Hz', 1/pd);

  % Overlay multiple harmonics and the combined result
yi = zeros(nmax, size(t,2));
y = zeros(size(t));
for ii = 1:nmax
  wn = ii*w1;
  an = sin(wn)/(wn);
  yi(ii,:) = an*cos(wn*t);
  y = y + yi(ii,:);
end

figure; hold on;
for ii = 1:nmax
  plot(t, yi(ii,:));
end
plot(t, y, 'linewidth',3);

  % Pull 2nd harmonic
wn = 2*w1;
yn = cos(wn*t);

  % Cartesian form
c0 = (2.0/pd)*trapz(t, y);
c2 = (2.0/pd)*trapz(t, yi(2,:).*cos(wn*t));
d2 = (2.0/pd)*trapz(t, yi(2,:).*sin(wn*t));

y2 = c0/2 + c2*cos(wn*t) + d2*sin(wn*t);
plot(t, y2, '*');

fprintf('\n');
