%% Amplitude over Distance Relation 
x = [0 2 4 6 8 10 12.2 14.1 16 18 20 22.1 24]; % Establish x values
amp = [897.5 819 700.5 593.5 457 411.5 553.5 608 523 374.5 228.5 102.9 68.75];
d_amp = [57.5 22 13.5 20.5 18 25.5 21.5 13 13 28.5 18.5 14.6 17.05];
d_x = 0.5 * ones(1,length(x))

%% Plotting
figure
hold on
errorbar(x,amp, d_amp, d_amp, d_x, d_x,'.k')
scatter(x(1),amp(1),'ok')
scatter(x(8),amp(8),'ok')
xlabel('Distance from tube (cm)')
ylabel('Amplitude(mV)')
legend('Measurement Point', 'Critical Points')
axis tight