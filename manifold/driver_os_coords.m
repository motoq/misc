% Plots surfaces representing a coordinate in the oblate spheroidal
% reference frame.

clear;
close all;

e = .9;                                          % Shape
a = 3.75;                                        % Semimajor axis length, units
lambda = pi*75/180;                              % Azimuth range
eta = 0.7;                                       % Elevation range

plt_os_surfaces(e, a, lambda, eta);

