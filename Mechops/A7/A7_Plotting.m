%% Plotting Part 1
%Notes:
%{
Graphs assume variables have been imported via use of uiimport or simply
dataimport.
Import Relavent Variables.

Name
------------------------------------------------
    -   Part 1
            * P1: 200 Hz Sine Wave Power Spectrum at 1000 Hz Sampling
            Frequency and 1024 Samples. Variables: f1, p1
            * P2: 200 Hz Square Wave Power Spectrum at 10000 Hz Sampling
            Frequency and 4096 Samples. Variables: f2, p2 
    -   Part 2 
            * P3: 2000 Hz Sine Wave Power Spectrum at 10000 Hz Sampling
            Frequency and 4096 Samples. Variables: f3, p3
            * P4: 2000 Hz Sine Wave Power Spectrum at 2500 Hz Sampling
            Frequency and 4096 Samples. Variables: f4, p4
            * T1: 2000 Hz Sine Wave Time Trace at 40000 Hz Sampling
            Frequency and 1024 Samples.
            * T2: 2000 Hz Sine Wave Time Trace at 2000 Hz Sampling
            Frequency and 4096 Samples
            * T3: 1000 Hz Sine Wave Time Trace at 2000 Hz Sampling
            Frequency and 128 Samples
    -   Part 3
            * P5: Mystery Signal Power Spectrum at 2000 Hz Sampling
            Frequency and 4096 Samples
            * P6: Mystery Signal Power Spectrum at 1000 Hz Sampling
            Frequency and 4096 Samples
            * T4: Mystery Signal Time Trace at 50000 Hz Sampling
            Frequency and 4096 Samples 

%}
% Set Data To Ignore (Usually placed to ignore DC Offset at frequencies
% below 5 Hz
n = 3;
%Creation of semilogx plots. Y axis is already logarithmic (in dB units)
figure('Name','Part 1: Square vs Sine Wave')
semilogx(f1(n:end),p1(n:end),f2(n:end),p2(n:end)+ 60 * ones(length(p2(n:end)),1),'--')

% Setting details and labels
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
legend('Sine Signal','Square Signal','Location','Northwest')
axis tight

%% Plotting Part 2
% Plotting power spectra
figure('Name','Part 2: Aliasing Analysis')
semilogx(f3(n:end),p3(n:end),f4(n:end),p4(n:end) + 60 * ones(length(p4(n:end)),1),'--')

% Setting details and labels
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
legend('Sine Signal','Aliased Sine Signal','Location','Northwest')
axis tight

% Plottng time traces
figure('Name', 'Part 2: Time-Traces')
plot(t1,v1,':',t2,v2,'--',t3,v3)
xlabel('Time (s)')
ylabel('Voltage (V)')
legend('Sampling at 40000 Hz','Sampling at 2500 Hz','Sampling at 2000 Hz')
axis([0,max(t1), -max(v1)-0.5, max(v1)+0.5])

%% Plotting Part 3
% Ploting Mystery Time Trace
figure('Name','Part 3: Mystery Signal Trace')
plot(t4,v4)
xlabel('Time (s)')
ylabel('Voltage (V)')
axis tight

% Plotting Mystery Power Spectra
figure('Name','Part 3: Mystery Signal Power Spectra')
plot(f5(n:end),p5(n:end),f6(n:end),p6(n:end) + 100* ones(length(p6(n:end)),1),'--')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
legend('Signal Sampled at 2000 Hz', 'Signal Sampled at 1000 Hz')
axis tight