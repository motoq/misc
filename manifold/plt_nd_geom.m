function plt_nd_geom(Cov, pos, pnt, tp, xp)
% PLT_ND_GEOM plots an n-dimensional hyperillipsoid as n-2 3D
% ellipsoids, along with a reference point location, pointing vector
% originating from the reference point, and two additional points.
% 3D systems will be plotted in the original reference frame, with a
% 2nd plot illustrating a 2D slice through the 3D ellipsoid.  Higher
% dimensional systems will be plotted with the x-axis aligned with the
% position vector and the y-axis in the direction of the pointing
% vector, and n-2 slices based on n-2 normal basis vectors to the span
% of the position and pointing vectors.
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
%   Cov  Positive definite symmetric matrix of dimension 3 or greater,
%        nxn
%   pos  Position of reference point, nx1
%   pnt  Pointing vector originating from reference point, nx1
%   tp   Tangent point to plot, connected to the reference point by
%        a green line (or any other point of interest), nx1
%   xp   Optional intersectoin (or other 2nd arbitrary) point to plot,
%        nx1
%
% Kurt Motekew  2022/10/27
% 
  dim = size(Cov,1);

    % Transformation to position/pointing reference frame
  T = mth_nd_to_2d(pos, pnt, true);

  dotsum = 0;
  for ii = 1:dim
    for jj = (ii+1):dim
      u1 = T(ii,:)';
      u2 = T(jj,:)';
      dotsum = dotsum + dot(u1, u2);
    end
  end

    % Plot n-2 3D slices of n-d hyperellipsoid.
    % Interate to each normal the the span of pos and pnt
  f3d = figure; hold on;
  f2d = figure; hold on;
  for ii = 3:dim
    figure(f3d);
      % Transform to frame with x-axis aligned with pos,
      % y-axis in the direction of pnt, and n-2 z-axes
      % normal to the x and y axes.
    posT = T*pos;
    pntT = T*pnt;
    tpT = T*tp;
    CovT = T*Cov*T';
    W = CovT^-1;
      % First three dimensions of current transformation
    pos3D = posT(1:3);
    pnt3D = pntT(1:3);
    tp3D = tpT(1:3);
    W3D = W(1:3, 1:3);
    Cov3D = W3D^-1;
    matrix3X3_plot(Cov3D, 35, true);
    plot3([0, pos3D(1)], [0, pos3D(2)], [0, pos3D(3)], 'b', 'linewidth', 2);
    %plot3([0, pos3D(1)], [0, pos3D(2)], [0, pos3D(3)], 'b', 'linewidth', 2);
      % Black pointing vector - scale back based on reference
      % point location 
    pnt3D = 0.5*norm(pos3D)*pnt3D/norm(pnt3D);
    quiver3(pos3D(1), pos3D(2), pos3D(3),...
            pnt3D(1), pnt3D(2), pnt3D(3), 'color', [0 0 0],...
                                          'linewidth', 2,...
                                          'AutoScale','off');
      % Green for tangent point, blue for reference point
    plot3([pos3D(1), tp3D(1)],...
          [pos3D(2), tp3D(2)],...
          [pos3D(3), tp3D(3)], 'g', 'linewidth', 2);
    scatter3(pos3D(1), pos3D(2), pos3D(3), 'b', 'filled');
    scatter3(tp3D(1), tp3D(2), tp3D(3), 'g', 'filled');
      % Plot intersection, in red, if present
    if nargin == 5
      xpT = T*xp;
      xp3D = xpT(1:3);
      plot3([pos3D(1), xp3D(1)],...
            [pos3D(2), xp3D(2)],...
            [pos3D(3), xp3D(3)], 'r', 'linewidth', 2);
      scatter3(xp3D(1), xp3D(2), xp3D(3), 'r', 'filled');
    end
      % Permute orthonormal transformation matrix
    u = T(3,:);
    for jj = 4:dim
      T(jj-1,:) = T(jj,:);
    end
    T(dim,:) = u;

    figure(f2d);
    W2D = W(1:2, 1:2);
    Cov2D = W2D^-1;
    [smajor, sminor, orient] = mth_cov2ellipse_eig(Cov2D);
    [xvals, yvals] = mth_ellipse(0, 0, smajor, sminor, orient, 40);
    plot(xvals, yvals, 'k', 'linewidth', 3);
    plot([0 pos3D(1)], [0 pos3D(2)], 'b', 'linewidth', 2);
    plot([pos3D(1) tp3D(1)], [pos3D(2) tp3D(2)], 'g', 'linewidth', 2);
    quiver(pos3D(1), pos3D(2),...
           pnt3D(1), pnt3D(2), 'color', [0 0 0],...
                                          'linewidth', 2,...
                                          'AutoScale','off');
    scatter(pos3D(1), pos3D(2), 'b', 'filled');
    scatter(0, 0, 'b', 'filled');
    scatter(tp3D(1), tp3D(2), 'g', 'filled');
    if nargin == 5
      plot([pos3D(1) xp3D(1)], [pos3D(2) xp3D(2)], 'r', 'linewidth', 2);
      scatter(xp3D(1), xp3D(2), 'r', 'filled');
    end
  end
  figure(f3d);
  plot(xvals, yvals, 'm', 'linewidth', 3);
  svals = svd(Cov);
  stitle = sprintf('%i-D, Singular Values from %1.3f to %1.3f',...
                   dim, max(svals), min(svals));
  xlabel('X (pos)');
  ylabel('Y (in-pnt)');
  zlabel('Z');
  title(stitle);
  axis equal;
  %print -depsc2 3d_nd.eps
    % Update 2D plot
  figure(f2d);
  svals = svd(Cov2D);
  stitle = sprintf('2-D Intersection, Singular Values %1.3f and %1.3f',...
                   svals(1), svals(2));
  xlabel('X (pos)');
  ylabel('Y (in-pnt)');
  title(stitle);
  axis equal;
  %print -depsc2 2d_nd.eps
