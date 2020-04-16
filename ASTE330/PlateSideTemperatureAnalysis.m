%% Analysis of Flat Aluminum Plate Side Temperatures (1D Front and Back)
%% Constants
T_0 = 489.505; % In kelvin 
Qsun = 1353;
Qearth = 209.853; % Calculated at altitude of 400 km 
deltaT = 0.5; % Approximated by T_0 relation through linearization of system of equations
bec = 1.361e-8 % Resultant product from boltzman constant and emissivity of polished aluminum 
%% Computations
w = linspace(1,10e7,10000);
Qcond = 205 * deltaT ./ w; % Approximated for relatively constant change in T  

TB = nthroot(((Qearth - Qcond) / bec),4); % Solved for TB from first equation

TF = nthroot(((Qsun + Qcond) / bec),4); % Solved for TF from second equation

%% Plotting
figure()
hold on
semilogx(w, TB)
semilogx(w, TF) 
xlabel('Plate Thickness m')
ylabel('Temperature in K')
legend()