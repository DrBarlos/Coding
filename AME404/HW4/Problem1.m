%{
Carlos A. Sanchez
HW4
%} 
%% Setup
tspan = [0 5000];
x_0 = [2.0 2.0 0];
eps = [2.25, 3.1, 4.0, 4.8];
phaseplots = figure()
spectrum = figure()

%% Calculations
for i = 1:length(eps)
    %ODE Solver
    [t, x] = ode45(@odefun,tspan,x_0,[], eps(i));
    
    % Interpolation (Time Uniformization)
    N2 = 2 ^ nextpow2(length(t));
    T = t(end) - t(1);
    dt2 = T/N2;
    t2 = dt2 * [0:(N2 - 1)];
    x2 = [spline(t,x(:,1),t2), 
        spline(t,x(:,2),t2), 
        spline(t,x(:,3),t2)]';
    
    % Fourier Analysis
    a = fft(x2(:,1));
    e = a.* conj(a) /N2^2;
    omega = 2 * pi /T * [0 : N2/2];
    
    % Basic Period finder
    [maxpower, ip] = max(e);
    T1 = 2 * pi/omega(ip);
    [tmp, it] = min(abs(t-15*T1));
    
    % Printing
    fprintf('For epsilon %3.3f, the basic frequency is %3.3f \n', eps(i),omega(ip))
    fprintf('For epsilon %3.3f, the basic period is %3.3f \n',eps(i),T1)
    
    
    % Plotting
    figure(spectrum)
    title(['\epsilon = ',num2str(eps(i))])
    subplot(2,2,i)
    loglog(omega,e(1:(N2/2 + 1)));
    xlabel('Frequency \omega'), ylabel('Power') 
    
    figure(phaseplots)
    title(['\epsilon = ',num2str(eps(i))])
    subplot(2,2,i)
    plot3(x2(it:end,1),x2(it:end,2),x2(it:end,3)), hold on;
    xlabel('x_1'), ylabel('x_2'), zlabel('x_3')
end