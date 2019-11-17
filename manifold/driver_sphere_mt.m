% Plots a sphere along with basis vectors and metric spaces
%
% Kurt Motekew
% 2019/11/17
%

clear;

  % Define Oblate spheroid with fixed size
r = 3.75;
thetas = 0:pi/8:pi;
phis = -pi:pi/8:pi;

figure;
hold on;
colormap([.5 .5 .3]);
hidden('off');

nel = size(thetas,2);
naz = size(phis,2);
for ii = 1:naz
  for jj = 1:nel
      % Cartesian origin for each spherical coordinate
    xyz = mth_sphere2cart(r, thetas(jj), phis(ii));
      % Metric tensor
    gij = mth_sphere_mt_cov(r, thetas(jj), phis(ii));
      % Basis vectors
    dxds = mth_dcart_dsphere(r, thetas(jj), phis(ii));
    e1 = dxds(:,1);
    e2 = dxds(:,2);
    e3 = dxds(:,3);
    ne2 = norm(e2);
    ne3 = norm(e3);
    if (ne2 ~= 0)  &&  (ne3 ~= 0)
      e1 = e1/norm(e1);
      e2 = e2/ne2;
      e3 = e3/ne3;
      quiver3(xyz(1), xyz(2), xyz(3), e1(1), e1(2), e1(3),...
                           'color',[1,0,0],'linewidth',3);
      quiver3(xyz(1), xyz(2), xyz(3), e2(1), e2(2), e2(3),...
                           'color',[0,1,0],'linewidth',3);
      quiver3(xyz(1), xyz(2), xyz(3), e3(1), e3(2), e3(3),...
                           'color',[0,0,1],'linewidth',3);
        % Orthogonal metric space - create direct transformation from
        % from basis vectors to orient (rotate) in computational frame
      C = [e1 e2 e3];
      gij = C*gij*C';

      [XX, YY, ZZ] = matrix3X3_points(gij/(8*r*r), 20);
      mesh(XX + xyz(1), YY + xyz(2), ZZ + xyz(3));
    end
  end
end 

title('Sphere with Basis Vectors and Metric Tensors');
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;



