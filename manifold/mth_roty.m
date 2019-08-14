function dcm = mth_roty(alpha)
% MTH_ROTY creates a DCM that performs a reference frame transformation about
% the y-axis by the angle alpha
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
  dcm(3,3) =  ca;
  dcm(3,1) =  sa;
  dcm(2,2) =   1;
  dcm(1,3) = -sa;
  dcm(1,1) =  ca;
