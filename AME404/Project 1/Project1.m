%% Project 1: Aeroelasticity Analysis
%{
-------------------------------------------
Carlos A. Sanchez
AME 404
%}

%% Section 1: Linear Model
clear all; clc; close all;
U = linspace(0,1.1,40);

% Parameters
x_cg = 1/5;
r_ea = 1/2;
x_e = 2/5; 
C_Lalph = 2*pi;
m = 5* pi;
m1 = [4*pi, 5*pi, 6*pi];
alp_0 = 0;
omega_r = 1/2;
mu = 1 + 3 * alp_0^2;

f1 = figure('Name','Growth Rates and Modal Frequencies');
f2 = figure('Name','Amplitude Ratio and Phase Difference');
f3 = figure('Name','Different Masses');

n_loop = length(U);
k_loop = length(m1);

% Create and Preload Arrays
sigma1_U = ones(1,n_loop);
omega1_U = ones(1,n_loop);
sigma2_U = ones(1,n_loop);
omega2_U = ones(1,n_loop);
sigma1m_U = ones(k_loop,n_loop);
omega1m_U = ones(k_loop,n_loop);
R_U = ones(1,n_loop);
phs_U = ones(1,n_loop); 

for i = 1:n_loop
    r = U(i);
% Coefficient Calculation 
    a1 = mu * ((U(i) * C_Lalph) / (2 * m)) * (1 + ((x_cg * x_e) / r_ea^2)) / (1 - (x_cg / r_ea)^2);
    a2 = omega_r^2 / (1 - (x_cg/r_ea)^2);
    a3 = (mu * ((U(i)^2 * C_Lalph)/ (2 * m)) * (1 + (x_cg* x_e /r_ea^2)) - x_cg ) / (1- (x_cg/ r_ea)^2);

    b1 = ((1 - mu * ((U(i)^2 * C_Lalph)/ (2 * m)) * (x_e + x_cg)/ r_ea^2))/ (1 - (x_cg/r_ea)^2);
    b2 = (- mu * ((U(i) * C_Lalph) / (2 * m)) * ((x_e + x_cg)/ r_ea^2) )/ (1 - x_cg^2/r_ea^2);
    b3 = (- omega_r^2 * (x_cg / r_ea^2) )/ (1 - (x_cg/r_ea)^2);

% Matrix Creationx
    A = [
         0, 1, 0, 0;
        -a2, -a1, -a3, 0;
        0, 0, 0, 1;
        -b3, -b2, -b1, 0
        ];

% Calculation of Eigenvalues 
    [eps, D] = eig(A); % Calculation of Eigenvectors
    [eigenval_s, eig_ind] = sort(diag(D)); % Uses sort, which outputs both a sorted set of eigenvalues,  
    Ds = D(eig_ind, eig_ind);
    eps_s = eps(:, eig_ind);
    
    sigma_iter = real(eigenval_s);
    omega_iter = imag(eigenval_s);
    
    sigma1_U(i) = sigma_iter(3);
    omega1_U(i) = omega_iter(3);
    sigma2_U(i) = sigma_iter(1);
    omega2_U(i) = omega_iter(1);
    
% Amplitude Ratio Calculation
    dangerousM = eps_s(:,end);
    abs_dangerousM = abs(dangerousM); % Can simply take absolute value of last eigenvector, since it is sorted.
    abs_hd = abs_dangerousM(1);
    abs_alpd = abs_dangerousM(3);
    R_iter = abs_hd / abs_alpd;
    R_U(i) = R_iter;
    
% Phase Difference
    img_ratio = imag(dangerousM(1) / dangerousM(3));
    real_ratio = real(dangerousM(1) / dangerousM(3));
    phs_iter = atan2(img_ratio, real_ratio);
    phs_U(i) = phs_iter;
    
% Using Different Masses
for k = 1:k_loop
% Coefficient Calculation 
    a1 = mu * ((U(i) * C_Lalph) / (2 * m1(k))) * (1 + ((x_cg * x_e) / r_ea^2)) / (1 - (x_cg / r_ea)^2);
    a2 = omega_r^2 / (1 - (x_cg/r_ea)^2);
    a3 = (mu * ((U(i)^2 * C_Lalph)/ (2 * m1(k))) * (1 + (x_cg* x_e /r_ea^2)) - x_cg ) / (1- (x_cg/ r_ea)^2);

    b1 = ((1 - mu * ((U(i)^2 * C_Lalph)/ (2 * m1(k))) * (x_e + x_cg)/ r_ea^2))/ (1 - (x_cg/r_ea)^2);
    b2 = (- mu * ((U(i) * C_Lalph) / (2 * m1(k))) * ((x_e + x_cg)/ r_ea^2) )/ (1 - x_cg^2/r_ea^2);
    b3 = (- omega_r^2 * (x_cg / r_ea^2) )/ (1 - (x_cg/r_ea)^2);

% Matrix Creation
    A = [
         0, 1, 0, 0;
        -a2, -a1, -a3, 0;
        0, 0, 0, 1;
        -b3, -b2, -b1, 0
        ];

% Calculation of Eigenvalues 
    [eps, D] = eig(A); % Calculation of Eigenvectors
    [eigenval_s, eig_ind] = sort(diag(D)); % Uses sort, which outputs both a sorted set of eigenvalues,  
    Ds = D(eig_ind, eig_ind);
    eps_s = eps(:, eig_ind);
    
    sigma_iter1 = real(eigenval_s);
    omega_iter1 = imag(eigenval_s);
    sigma1m_U(k,i) = max(sigma_iter1);
    omega1m_U(k,i) = omega_iter1(4);
    
end
end
% Plotting
figure(f1);

subplot(2,1,1)
scatter(U, sigma1_U, '.b'), hold on
scatter(U, sigma2_U, '*r')
legend({'\sigma_1','\sigma_2'},'Location','south','Orientation','horizontal')
xlabel('Flow Speed (U)'), ylabel('Growth Rate (\sigma)')  

subplot(2,1,2)
scatter(U, omega1_U, '.b'), hold on
scatter(U, omega2_U, '*r')
legend({'\omega_1','\omega_2'},'Location','south','Orientation','horizontal')
xlabel('Flow Speed (U)'), ylabel('Modal Frequency (\omega)')

figure(f2);

subplot(2,1,1)
scatter(U, R_U, '.k'), hold on
legend({'R'},'Location','north','Orientation','horizontal')
xlabel('Flow Speed (U)'), ylabel('Amplitude Ratio (R)')  

subplot(2,1,2)
scatter(U, phs_U, '.k'), hold on
legend({'\phi'},'Location','north','Orientation','horizontal')
xlabel('Flow Speed (U)'), ylabel('Phase Difference (\phi)')

figure(f3);
hold on

% Slight Interpolation
Ut = 0:0.00001:1.1;
for l = 1:k_loop
    sigma_interpol = spline(U,sigma1m_U(l,:), Ut);
    omega_interpol = spline(U,omega1m_U(l,:), Ut);
    plot(Ut, sigma_interpol)
    k_index = find(sigma_interpol < 0, 1, 'last');
    U_c = Ut(k_index);
    omega_c = omega_interpol(k_index);
    scatter(U_c, sigma_interpol(k_index),'*')
    fprintf('For a wing of mass %f, the critical speed is approximately %f with a frequency of %f\n', m1(l) , U_c, omega_c);
    hold on
end
plot([0 1.2], [0,0],'-.k')
legend({'4\pi', 'U_{c1}','5\pi','U_{c2}','6\pi','U_{c3}'},'Location','northwest','Orientation','vertical')
xlabel('Flow Speed (U)'), ylabel('Growth Rate (\sigma)')

%% Section 2: Nonlinear Model
% Setup
tspan = [0, 100];
x_0 = [0.1, 0, 0 , 0];
U = [0.5, 0.870388, 0.95];
j_max = length(U);


f4 = figure('Name','Nonlinear Model');
for j = 1:j_max
    % ODE Solver
    [t, x] = ode45(@odefun, tspan, x_0, [], U(j));

    subplot(3,1,j)
    yyaxis left
    plot(t,x(:,1)), hold on
    xlabel('Time (t)')
    ylabel('H')

    yyaxis right
    ylabel('Angle (\alpha)')
    plot(t,x(:,3))
end

% Fourier Analysis on Single U
U_i = 0.870388;
T = tspan(2) - tspan(1);
[tf, xf] = ode45(@odefun, tspan, x_0, [], U_i);

N2 = 2^nextpow2(length(tf));
dt2 = T/N2;
t_u = dt2 * [0:(N2-1)];
xf2 = spline(tf, xf(:,3),t_u);

a = fft(xf2(:,3));
e = a .* conj(a)/ N2^2;
omega = 2 * pi / T * [0: N2/2];

figure('Name','Power Spectra')
loglog(omega, e(1:N2/2 + 1))

% Varying Inititial Conditions
% As before, we will vary the initial conditions instead of U
tspan1 = [0, 600];
U1 = 0.9;
x_01 = [0.1, 0, 0, 0];
x_02 = [1.0, 0, 0, 0];

[t1,x1] = ode45(@odefun, tspan1, x_01, [], U1);
[t2,x2] = ode45(@odefun, tspan1, x_01, [], U1);

f5 = figure('Name', 'Varying initial Conditions');

subplot(2,2,1)
plot(t1, x1(:,1))
xlabel('Time (s)'), ylabel('Position (h)')

subplot(2,2,2)
plot(t1, x1(:,3))
xlabel('Time (s)'), ylabel('Angle (\alpha)')

subplot(2,2,3)
plot(t2, x2(:,1))
xlabel('Time (s)'), ylabel('Position (h)')

subplot(2,2,4)
plot(t1, x1(:,3))
xlabel('Time (s)'), ylabel('Angle (\alpha)')
