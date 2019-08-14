function dcm = mth_rotx(alpha)
% MTH_ROTX creates a DCM that performs a reference frame transformation about
% the x-axis by the angle alpha
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
  dcm(3,2) = -sa;
  dcm(2,3) =  sa;
  dcm(2,2) =  ca;
  dcm(1,1) =   1;
