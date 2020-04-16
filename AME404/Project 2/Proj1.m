% Constant Setup
clc ; close all;
global mu omega
mu = 700;
omega = 25;
e = 0.035;
beta = -0.1;
a0 = 0.1;
itmax = 1000;
reltol = 10e-5;
abstol = 10e-8;
dmu = 10e-4;
dbeta = 10e-4;
sigma = 0.05;

tol = 10e-5;
xspan = [e,1];
opts = odeset('RelTol',reltol,'AbsTol',abstol);
for i = 1:itmax
    %% Step 1
    int = [0,0,a0, beta];
    [x1,z1] = ode45(@odefun,xspan,int,opts);
    d2z_dx2_k = z1(end,3); d3z_dx3_k = z1(end,4) ;
    
    %% Step 2
    if abs(z1(end,3)) < tol && abs(z1(end,4)) < tol
        break;
    end
    
    %% Step 3
    mu0=mu;
    mu = mu + dmu;
    int = [0,0,a0, beta];
    [x2,z2] = ode45(@odefun,xspan,int,opts);
    d2z_dx2_kmu = z2(end,3); d3z_dx3_kmu = z2(end,4);
    
    %% Step 4
    mu=mu0;
    beta0 = beta;
    beta = beta + dbeta;
    int = [0,0,a0, beta];
    [x3,z3] = ode45(@odefun,xspan,int,opts);
    d2z_dx2_kbeta = z3(end,3); d3z_dx3_kbeta = z3(end,4);
    
    %% Step 5
    J = [ (d2z_dx2_kmu -  d2z_dx2_k)/dmu, (d2z_dx2_kbeta - d2z_dx2_k)/dbeta;
         (d3z_dx3_kmu - d3z_dx3_k)/dmu, (d3z_dx3_kbeta - d3z_dx3_k)/dbeta];
    v_c = [-d2z_dx2_k; -d3z_dx3_k];
    delta = linsolve(J, v_c);
    mu = mu + sigma*delta(1);
    beta = beta0 + sigma*delta(2);
    i_max = i;
end

if i_max < itmax % Proceed
    fprintf('Converges\n')
    x = x1(:,1);
    z_max = max(z1(:,1));
    z = z1(:,1) / z_max;
    lambda = sqrt(mu);
    fprintf('Modal frequency is %f\n', lambda)
    plot(x,z)
end