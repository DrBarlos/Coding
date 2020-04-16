function dxdt = odefun(t,x,U)
% Parameters
x_cg = 1/5;
r_ea = 1/2;
x_e = 2/5; 
C_Lalph = 2*pi;
m = 5* pi;
alp_0 = 0;
omega_r = 1/2;
r = -0.1;

% Subfunction Definitions
alp_p = x(3) + atan2(x(2),U);
mu = 1 + 3 * alp_0^2;
f_alp_p = 3 * alp_0 * alp_p^2 + alp_p^3;


% Function Definition
dxdt = [ x(2);
    (-((U^2 * C_Lalph)/(2 * m)) * (1 + (x_e * x_cg / r_ea^2) * (cos(alp_0 + x(3)))^2) * (mu * alp_p + r * f_alp_p) ... 
    + x_cg * x(4)^2 * sin(alp_0 + x(3)) + x_cg * x(3) * cos(alp_0 + x(3))) /(1 - (x_cg/r_ea)^2 * cos(alp_0 + x(3))^2);
    x(4);
    (((U^2 * C_Lalph)/(2 * m)) * ((x_e + x_cg) / r_ea^2) * (mu * alp_p + r * f_alp_p) * cos(alp_0 + x(3)) ...
    - (1/2) * (x_cg/r_ea)^2 * x(4)^2 * sin(2 * (alp_0 + x(3)) ) + (x_cg /r_ea^2) * omega_r^2 * x(1) * cos(alp_0 + x(3))) ...
    /(1 - (x_cg/r_ea)^2 * cos(alp_0 + x(3)) )];
end