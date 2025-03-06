function app_nd_xtan(pos, pnt, Cov)
% APP_ND_XTAN Computes the intersection, if present, and tangent points
% to a hyperellipsoid given position and pointing vectors.
%
%-----------------------------------------------------------------------
% Copyright 2022 Kurt Motekew
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%-----------------------------------------------------------------------
%
% Inputs:
%   pos  Position of reference point, nx1
%   pnt  Pointing vector originating from reference point, nx1
%   Cov  Positive definite symmetric matrix of dimension 3 or greater,
%        nxn
%
% Kurt Motekew  2022/10
%

  dim = size(Cov,1);
  
  W = Cov^-1;
  [V, D] = eig(Cov);
  
    % Scaling is the inverse of the square root of each element
  Scale = (sqrt(D))^-1;
  Rot = V';
  Tac = Scale*Rot;
  Tca = Tac^-1;
  
  posAff = Tac*pos;
  pntAff = Tac*pnt;
  
  T2a = mth_nd_to_2d(posAff, pntAff, true);
  pos2d = T2a*posAff;
  pnt2d = T2a*pntAff;
  tp2d = mth_circle_tan(pos2d(1:2), pnt2d(1:2));
    % 2D frame -> 3D frame
  tpAff = T2a'*[tp2d ; zeros(dim-2,1)];
  tp = Tca*tpAff;
  
  fprintf('\nDeterminant of ND to 2D: %1.1e', det(T2a));
  fprintf('\n\nPosition magnitude %1.3f', norm(pos));
  
    % Chi^2 indicates on surface.  Rank 2 means position, pointing, and
    % tangent vectors are all in the same plane.
  fprintf('\n\nChi^2 on tangent is %1.6f', tp'*W*tp);
  fprintf(' with rank %1i of 3', rank([pos pnt tp]));
  fprintf('\nRange on tangent is %1.3f', norm(tp - pos));
  if mth_is_tanpt(pos, tp, Cov)
    fprintf('\nConfirmed tangent point');
  else
    fprintf('\nNOT confirmed tangent point.');
  end
  
  [xp2d, missed] = mth_circle_x(pos2d(1:2), pnt2d(1:2));
  [xpnd, ~] = mth_nsphere_x(posAff, pntAff);
  if missed
    fprintf('\n\nNo intersection');
  else
    xpAff = T2a'*[xp2d ; zeros(dim-2,1)];
    xp = Tca*xpAff;
    xpnd = Tca*xpnd;
    r_xp_pos = xp - pos;
    r_xp_pos_hat = r_xp_pos/norm(r_xp_pos);
    cang = dot(r_xp_pos_hat, r_xp_pos_hat);
      % Chi^2 indicates on surface.  Rank 2 means position, pointing, and
      % tangent vectors are all in the same plane.  Cosine angle between
      % pointing and position to intersection point = 1 means colinear.
    fprintf('\n\nIntersection:  Chi^2 is %1.6f', xp'*W*xp);
    fprintf(' with rank %1i of 3', rank([pos pnt xp]));
    fprintf('\nCosine angle between pointing and intersection is %1.3e', cang);
    fprintf('\nRange on intersection is %1.3f', norm(xp - pos));
    fprintf('\nDifference between 2d and nd x is %1.2e', norm(xp - xpnd));
    if mth_is_xpt(pos, xp, Cov)
      fprintf('\nConfirmed nearest intersection point');
    else
      fprintf('\nNOT confirmed nearest intersection point');
    end
    if dim == 3
      fprintf('\nAlignment error %1.1e', norm(cross(xp - pos, pnt)));
      fprintf('\nAxis alignment error %1.1e', dot(tp, cross(pos, pnt)));
    end
  end
  
  if missed
    plt_nd_geom(Cov, pos, pnt, tp);
  else
    plt_nd_geom(Cov, pos, pnt, tp, xp);
  end
  
  fprintf('\n\n');

