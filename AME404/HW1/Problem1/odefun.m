function dhdt = odefun(t,h,Q_in); % Define class of function

% Parameters
d = 0.025; % Outlet radius (m)
R = 0.5; % Cylinder Tank Radius (m)
C_d = 0.8; % Drag Coefficient 
g = 9.81; % Acceleration due to gravity (m/s^2)

%Area Calculation
A_d = 1/4 * d^2;

%Inhomogenous function
dhdt = (1/(pi * R^2)) * (Q_in - C_d * A_d * sqrt(2 * g * h));

end


