%% Creating FFT from Time Traces
%{
It is assumed that the appropriate variables have already been imported,
thus I will not add this into this code (this is self-explanatory), This
code only switches from time domain to frequency domain.

Import: 
amin - Minimum voltage recorded
amax - Maximum voltage recorded
dT_sample - amount of time per sample
%}
%% Creating Averages
a = (amax+amin)/2;
n_samples = length(a) % Gives length of vector
f_sample = 1/(dT_sample*10^-9) % in Hz
sampleTime = n_samples * dT_sample % Total sample time
time = linspace(0,sampleTime, n_samples)

%% Plotting Time Trace
figure(1)
plot(time, a)
xlabel('Time (s)')
ylabel('Amplitude (mV)')

%% FFT and FFT Plot
signal_FFT = fft(a,n_samples)/n_samples %Run FFT
amp = 2 * abs(signal_FFT(1:n_samples/2+1))
frequency = f_sample/2 * linspace(0,1,n_samples/2+1)

figure(2)
plot(frequency, amp)
xlabel('Frequency (Hz)')
ylabel('Magnitude (mV)')