function [e_1, e_2, e_3] = mth_os_cov_basis(e, a, lambda, eta)
% MTH_OS_COV_BASIS computes the covariant basis vectors for the
% oblate spheroidal coordinate system.
%
%-----------------------------------------------------------------------
% Copyright 2020 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   e        Eccentricity, ellipsoid fit
%   a        Semimajor axis coordinate, defines size and units
%   lambda   Azimuth coordinate, -pi <= lambda <= pi
%   eta      Elevation coordinate, -1 <= eta <= 1
%
% Return
%   Covariant basis vectors (3x1) at a, lambda, eta
%
% Kurt Motekew   2020/04/29
%

  dxda = mth_dcart_dos(e, a, lambda, eta);
  e_1 = dxda(:,1);
  e_2 = dxda(:,2);
  e_3 = dxda(:,3);
