%% Turbulent Jets Plot 

%{ 
by Carlos A. Sanchez

Assumes importation of variables via organized list of variables as defined
below,
%} 

%{
Variable definitions:
    X lists: x{num of diameters away}D_x
    Y Lists: x(num of diameters away)D_Y
    Velocity: x(num of diameters away)D_u
    Velocity Uncertainty: x(num of diameters away)D_du
    Voltage Lists: x(num of diameters)D_V
%}

%% Setup 
% Constant Definitions
dY =  1; %error in Y
numD = 11; % Number of measurements of x variables
y_max = 198; % mm 
div_y = 2; % mm per sample
D = 0.01897; % (in m) Diameter of Jet flow outlet
nu_air = 10^(-6); % Kinematic Viscosity of air

%% Calculations
% Velocity Uncertainty
du1D = double_array_MaxComparator(x1D_du(1:100), x1D_du(101:200));
du2D = double_array_MaxComparator(x2D_du(1:100), x2D_du(101:200));
du3D = double_array_MaxComparator(x3D_du(1:100), x3D_du(101:200));
du4D = double_array_MaxComparator(x4D_du(1:100), x4D_du(101:200));
du5D = double_array_MaxComparator(x5D_du(1:100), x5D_du(101:200));
du6D = double_array_MaxComparator(x6D_du(1:100), x6D_du(101:200));
du7D = double_array_MaxComparator(x7D_du(1:100), x7D_du(101:200));
du8D = double_array_MaxComparator(x8D_du(1:100), x8D_du(101:200));
du9D = double_array_MaxComparator(x9D_du(1:100), x9D_du(101:200));
du10D = double_array_MaxComparator(x10D_du(1:100), x10D_du(101:200));
du11D = double_array_MaxComparator(x11D_du(1:100), x11D_du(101:200));

% Velocity Detrending
offset = 0.8;
dtrnd_u1D = x1D_u - offset * ones(200,1);
dtrnd_u2D = x2D_u - offset * ones(200,1);
dtrnd_u3D = x3D_u - offset * ones(200,1);
dtrnd_u4D = x4D_u - offset * ones(200,1);
dtrnd_u5D = x5D_u - offset * ones(200,1);
dtrnd_u6D = x6D_u - offset * ones(200,1);
dtrnd_u7D = x7D_u - offset * ones(200,1);
dtrnd_u8D = x8D_u - offset * ones(200,1);
dtrnd_u9D = x9D_u - offset * ones(200,1);
dtrnd_u10D = x10D_u - offset * ones(200,1);
dtrnd_u11D = x11D_u - offset * ones(200,1);

% 2D Plane Position Mesh
y = -y_max/2 :div_y:y_max/2;
x = 1:numD;
[X,Y] = meshgrid(x,y);

% Average Velocity Arrays
u1D = (dtrnd_u1D(1:100) + dtrnd_u1D(101:200))/2 ;
u2D = (dtrnd_u2D(1:100) + dtrnd_u2D(101:200))/2 ;
u3D = (dtrnd_u3D(1:100) + dtrnd_u3D(101:200))/2 ;
u4D = (dtrnd_u4D(1:100) + dtrnd_u4D(101:200))/2 ;
u5D = (dtrnd_u5D(1:100) + dtrnd_u5D(101:200))/2 ;
u6D = (dtrnd_u6D(1:100) + dtrnd_u6D(101:200))/2 ;
u7D = (dtrnd_u7D(1:100) + dtrnd_u7D(101:200))/2 ;
u8D = (dtrnd_u8D(1:100) + dtrnd_u8D(101:200))/2 ;
u9D = (dtrnd_u9D(1:100) + dtrnd_u9D(101:200))/2 ;
u10D = (dtrnd_u10D(1:100) + dtrnd_u10D(101:200))/2 ;
u11D = (dtrnd_u11D(1:100) + dtrnd_u11D(101:200))/2 ;

% Average Velocity Mesh
U = [u1D, u2D, u3D, u4D, u5D, u6D, u7D, u8D, u9D, u10D, u11D];

% Reynolds Mesh
Re1D = ((1 * D) / nu_air) * u1D;
Re2D = ((2 * D) / nu_air) * u2D;
Re3D = ((3 * D) / nu_air) * u3D;
Re4D = ((4 * D) / nu_air) * u4D;
Re5D = ((5 * D) / nu_air) * u5D;
Re6D = ((6 * D) / nu_air) * u6D;
Re7D = ((7 * D) / nu_air) * u7D;
Re8D = ((8 * D) / nu_air) * u8D;
Re9D = ((9 * D) / nu_air) * u9D;
Re10D = ((10 * D) / nu_air) * u10D;
Re11D = ((11 * D) / nu_air) * u11D;

Re = [Re1D, Re2D, Re3D, Re4D, Re5D, Re6D, Re7D, Re8D, Re9D, Re10D, Re11D];

% Turbulence Mesh
T1D = du1D ./ (u1D * 1000);
T2D = du2D ./ (u2D * 1000);
T3D = du3D ./ (u3D * 1000);
T4D = du4D ./ (u4D * 1000);
T5D = du5D ./ (u5D * 1000);
T6D = du6D ./ (u6D * 1000);
T7D = du7D ./ (u7D * 1000);
T8D = du8D ./ (u8D * 1000);
T9D = du9D ./ (u9D * 1000);
T10D = du10D ./ (u10D * 1000);
T11D = du11D  ./ (u11D * 1000);

T = [T1D,T2D,T3D,T4D,T5D,T6D,T7D,T8D,T9D,T10D,T11D];

% Calculating FWHM for each curve...
u1Dy_half = fwhm(y,u1D); % This is used through a public use license and permission according to EULA
u2Dy_half = fwhm(y,u2D);
u3Dy_half = fwhm(y,u3D);
u4Dy_half = fwhm(y,u4D);
u5Dy_half = fwhm(y,u5D);
u6Dy_half = fwhm(y,u6D);
u7Dy_half = fwhm(y,u7D);
u8Dy_half = fwhm(y,u8D);
u9Dy_half = fwhm(y,u9D);
u10Dy_half = fwhm(y,u10D);
u11Dy_half = fwhm(y,u11D);

% Normalizing the y axis
y1D = y ./ (ones(1,100)*u1Dy_half);
y2D = y ./ (ones(1,100)*u2Dy_half);
y3D = y ./ (ones(1,100)*u3Dy_half);
y4D = y ./ (ones(1,100)*u4Dy_half);
y5D = y ./ (ones(1,100)*u5Dy_half);
y6D = y ./ (ones(1,100)*u6Dy_half);
y7D = y ./ (ones(1,100)*u7Dy_half);
y8D = y ./ (ones(1,100)*u8Dy_half);
y9D = y ./ (ones(1,100)*u9Dy_half);
y10D = y ./ (ones(1,100)*u10Dy_half);
y11D = y ./ (ones(1,100)*u11Dy_half);

%% Plotting
% Flow Speeds (2D Plane)
figure(1)
hold on
errorbar(y, u1D, du1D,'. -r','MarkerSize',14)
errorbar(y, u5D ,du5D ,'. -g','MarkerSize',14)
errorbar(y, u9D ,du9D,'. -b','MarkerSize',14)
errorbar(y, u11D , du11D,'. -k','MarkerSize',14)
hold off
xlabel('Y (mm)')
ylabel('u (m/s)')

lgd = legend('1D','5D','9D','11D');
title(lgd,'Distance (in D)')
axis([-50 50 0 10.5])

% Flow Speeds (Contour Plot)
figure(2)
hold on
contourf(X,Y,U)
hold off
xlabel('x (in D)')
ylabel('y (mm)')
cbu = colorbar('southoutside');
cbu.Label.String = 'u (m/s)';

axis([1, 11, -45, 45])

% Reynolds Number
figure(3)
hold on
contourf(X,Y,Re)
hold off
xlabel('x (in D)')
ylabel('y (mm)')
cbRe = colorbar('southoutside');
cbRe.Label.String = 'Reynolds Number (Re)';

axis([1, 11, -45, 45])

% Turbulence (2D Plane)
figure(4)
hold on
plot(y3D, T3D, 'o r','MarkerSize',5)
plot(y5D,  T5D, 'o g','MarkerSize',5)
plot(y7D,  T7D, 'o b','MarkerSize',5)
plot(y9D, T9D, 'o k','MarkerSize',5)
plot(y11D, T11D, 'o m','MarkerSize',5)
hold off
xlabel('y*')
ylabel('u*')

lgd = legend('3D','5D','7D','9D','11D')
title(lgd,'Distance (in D)')

axis ([-4 4 0 0.35])

% Turbulence (Contour Plot)
figure(5)
hold on
contourf(X,Y,T,[-1,0, 0.002, 0.05, 0.1, linspace(0.11, 0.3,3)]);
hold off
xlabel('x (in D)')
ylabel('y (mm)')
cbT = colorbar('southoutside');
cbT.Label.String = 'Local Turbulence (u''/u_c)';
caxis([0 0.35])
axis tight
