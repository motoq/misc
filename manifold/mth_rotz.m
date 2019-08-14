function dcm = mth_rotz(alpha)
% MTH_ROTZ creates a DCM that performs a reference frame transformation about
% the z-axis by the angle alpha
%
% Input:
%   alpha   Rotation angle, radians
%
% Return:
%   dcm     Direction cosine matrix, [3x3] 
%
% Kurt Motekew   2014/10/19
%

  ca = cos(alpha);
  sa = sin(alpha);
  dcm(3,3) =   1;
  dcm(2,2) =  ca;
  dcm(2,1) = -sa;
  dcm(1,2) =  sa;
  dcm(1,1) =  ca;
