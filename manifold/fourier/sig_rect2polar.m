function [a, phi] = sig_rect2polar(c, d)
% SIG_RECT2POLAR converts a signal in the form of c*cos(wt) + d*sin(wt)
% to polar form, a*cos(wt - phi)

  a = sqrt(c*c + d*d);
  phi = atan2(d,c);

