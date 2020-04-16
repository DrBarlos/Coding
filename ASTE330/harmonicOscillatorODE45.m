function [tvals,xvals] = harmonicOscillatorODE45(x0, v0, m, k, c, T)
tspan = [0,T]; %Creates time interval from o to T
initialVals = [x0,v0]; % Array for initial values
[t_temp,x_temp] = ode45(@f,tspan,initialVals);
figure
plot(t_temp,x_temp(:,1)) %Use only first column (containing x), and not second (containing v)
axis auto
xlabel('Time(t)')
ylabel('Position(x)')
title('Harmonic Oscillator')

 function dxdt = f(t,x) % Creates Symbolic Function 
        dxdt(1) = x(2); % Seperates differential equation into system of first order eq
        dxdt(2) = (-c/m)*x(2) + (-k/m)*x(1); 
        dxdt = dxdt'; % ODE45 uses column vectors for some weird reason, so this must be transposed
    end
end

