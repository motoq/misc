%
% Plot the result of combining weighted sinusoids to create a square
% wave.
%
% Kurt Motekew  2022/07/31
%

clear;

  % Fundamental frequency, Hz
w1 = 1.0;

  % Period and increment
pd = 2*pi/w1;
dt = pd/100;
t = (-pd/2):dt:(pd/2);

fprintf('\nFundamental frequency %1.1f Hz', w1);
fprintf(' and Period %1.3e sec', pd);
fprintf('\n');

  % Overlay multiple harmonics and the combined result
figure; hold on;
y = zeros(size(t));
for ii = 1:8
  wn = ii*w1;
  an = sin(wn)/(wn);
  yn = an*cos(wn*t);
  plot(t, yn);
  y = y + yn;
end
plot(t, y, 'linewidth',3);

  % Single plot with many harmonics added
y = zeros(size(t));
for ii = 1:100
  wn = ii*w1;
  an = sin(wn)/wn;
  yn = an*cos(wn*t);
  y = y + yn;
end
figure; hold on;
plot(t, y, 'linewidth',3);


