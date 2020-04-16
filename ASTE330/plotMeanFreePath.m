function plotMeanFreePath

hvals = 100:100:1000; % Values of altitude (km) for which to compute

cm = 1e-2; % cm in SI units
amu = 1.66e-27; % atomic mass in kg

sigma = 1e-18 * cm^2; 
mu = 10 * amu; % Average molecular mass

i = 0; % for indexing mean free path values
for h = hvals
    rho = atmosphericDensity( h ); % Mass density
    n = rho / mu; % Number density
    % Pisacane (2.3.5)
    lambda = 1 / ( sqrt(2)*sigma*n );
    i = i + 1;
    lvals(i) = lambda; % store mfp in array for plotting
end

close all;
figure;
semilogy( hvals, lvals );
xlabel( 'Altitude, km' );
ylabel( 'Mean free path, m' );

    
