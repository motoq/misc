close all;
clear;

p = 360;
t = -180:1:180;

p = pi*p/180;
t = pi*t/180;

w0 = 2*pi/p;

c0 = 1.0;
d0 = 1.0; 


y0 = c0*cos(w0*t) + d0*sin(w0*t);

figure; hold on;
plot(t, y0);

figure; hold on;
for ii = 1:20
  yi = c0*cos(ii*w0*t) + d0*sin(ii*w0*t);
  plot(t, yi);
end
