%% Fobs Script 
% Calculates f_omega from power spectra and graphs spectra.
%{
Assumes that 
f_mat is frequency matrix
rp_mat is relative power matrix
%}
%% Peak Finding
[peaks,loc] = findpeaks(rp_mat,f_mat,'MinPeakDistance',30,'NPeaks',1); 
%Finds peaks based off prominenece and minimum distance between peaks
disp(loc(1)) %Displays frequency for recording purpose
%% Plotting
figure()
hold on

plot(f_mat,rp_mat,'k-')
plot(loc(1),peaks(1),'or','MarkerFaceColor','r')

xlabel('Frequency (Hz)')
ylabel('Relative Power (dB)')

legend('Spectrum', 'Natural Frequency','Orientation','horizontal')