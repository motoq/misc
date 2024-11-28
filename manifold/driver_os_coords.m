% Plots oblate spheroid coordinate surfaces

clear;
%close all;

e = .75;                                          % Shape
a = 7.5;                                        % Semimajor axis length, units
lambda = pi*70/180;                              % Azimuth range
eta = 0.5;                                       % Elevation range

plt_os_surfaces(e, a, lambda, eta);
plt_os_covariant(e, a, lambda, eta);
view([135, 15]);

%print -tight -depsc2 os_coord_surf.eps

