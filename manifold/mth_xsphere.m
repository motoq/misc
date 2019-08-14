function xyz = mth_xsphere(pos, pnt, a)
% MTH_XSPHERE Finds the intersection of a unit pointing vector to a
% sphere.
%
% Inputs:
%   pos  Cartesian location, source of pointing vector, [3x1]
%   pnt  Unit pointing vector, [3x1]
%   a    Radius of sphere, dictates units for pos and xyz
%
% Return:
%   xyz  Intersection of pnt extented from pos to the sphere.  If a
%        miss, then all elements of xyz are zero.
%
% Kurt Motekew   2019/08/13
%

  xyz = zeros(3,1);

  rx = pos(1);
  ry = pos(2);
  rz = pos(3);

  px = pnt(1);
  py = pnt(2);
  pz = pnt(3);

  a2 = a*a;

  alpha = (px*px + py*py + pz*pz)/a2;
  beta  = (rx*px + ry*py + rz*pz)/a2;
  gamma = (rx*rx + ry*ry + rz*rz)/a2;

  d = beta*beta - alpha*(gamma - 1);
  if d >= 0
    s = -(beta + sqrt(d))/alpha;
    xyz = pos + s*pnt;
  end
