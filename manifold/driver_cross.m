% Driver function to test the n-dimensional cross product function
%

u2d = [1 2]';
v2d = mth_cross(u2d);
fprintf('\n2D |V| = %1.3e and U dot V: %1.3e', norm(v2d), dot(u2d, v2d));

u = [1 2 3]';
v = [3 1 4]';
uv = [u v];
x1 = cross(u, v);
x2 = mth_cross(uv);

fprintf('\nDifference between 3D cross Product: %1.3e', norm(x2 - x1));

%
% Testing higher with randn time scale factor sf
%

sf = 1;
maxdim = 8;
for m = 2:maxdim
  n = m - 1;
  U = sf*randn(m,n);
  x = mth_cross(U);
  maxerr = 0;
  for ii = 1:n
    maxerr = max(maxerr, abs(x'*U(:,ii)));
  end
  fprintf('\nFor %i Dim |x| = %1.3e and Max Dot = %1.3e', m, norm(x), maxerr);
end


fprintf('\n');
