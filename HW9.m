%% Spacecraft Constants 
C = 100;
sigma = 0.5;
Nx = 20;

%% Initial Conditions
Omega = pi;
lambda = (sigma-1)*Omega;
deltaT = 1/2 * ((2*pi)/abs(lambda));
nu_theta = pi/4;
w0 = sigma * tan(nu_theta) * Omega;

%% Iterations
n = 0;
while nu_theta > 0
    n = n + 1;
    theta_pulse = atan((Nx/(C*Omega))* ((sin(lambda * (deltaT/2)))/(lambda * (deltaT/2))));
    Omega = w0/(tan(nu_theta)*sigma);
    nu_theta = nu_theta - theta_pulse;
    del_w0 = theta_pulse * sigma * Omega;
    w0 = w0 - del_w0;
    del_Omega = w0/(tan(nu_theta)* sigma);
    Omega = Omega - del_Omega;
end

fprintf('It takes %i pulses to eliminate the nutation\n',n)