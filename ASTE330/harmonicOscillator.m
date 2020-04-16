function [tvals,xvals] = harmonicOscillator(x0, v0, m, k, c, T)
%UNTITLED Second Order ODE Solver
%   Uses Euler's method to solve for differential equation
deltat = 0.01; % Step size
vi = v0;
xi = x0;
ti = 0;
x_temp = [x0];
t_temp = [ti];
while ti < T
    vi = vi +((-c/m)*vi*deltat-(k/m)*xi*deltat);
    xi = xi + deltat*vi;
    ti = ti + deltat;
    x_temp = [x_temp,xi];
    t_temp = [t_temp, ti];
end
figure
plot(t_temp,x_temp)
xlabel('Time(t)')
ylabel('Position(x)')
title('Harmonic Oscillator')
tvals = t_temp;
xvals = x_temp;

end


