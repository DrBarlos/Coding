function dxdt = odefun(t,x,omega)
% Parameters
omega_0 = 1;
zeta = 0.1;
alpha = 0.1;
f_0 = 0.7;

% Function Definition (Matrix form) 
dxdt = [x(2) ; -2 * zeta * omega_0 * x(2) - omega_0^2 * (x(1)+ alpha * x(1)^3) + f_0 * cos(omega * t) ];
end

