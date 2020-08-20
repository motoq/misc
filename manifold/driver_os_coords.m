% Plots oblate spheroid coordinate surfaces

clear;
close all;

e = .9;                                          % Shape
a = 3.75;                                        % Semimajor axis length, units
lambda = pi*75/180;                              % Azimuth range
eta = 0.7;                                       % Elevation range

plt_os_surfaces(e, a, lambda, eta);
view([135, 15]);

%print -depsc2 os_coord_surf.eps

