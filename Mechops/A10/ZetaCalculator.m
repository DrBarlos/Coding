%% Zeta Calculator
% Creates Time trace and returns zeta values for as many peaks as possible
%{
Assumes that 
t_mat is time matrix
V_mat is voltage matrix
%}

%% Calculations
[V_peaks, peak_loc]=findpeaks(V_mat,t_mat,'MinPeakDistance',0.01,'MinPeakHeight',0); %Finds local peaks of data
x_0 = V_peaks(1); % Sets x_0 of data set
n_calc = length(V_peaks) - 1; % Calculates number of calculations required

zeta_arr = ones(1,n_calc); % Precreates Array 

for i = 1:n_calc %calculates zeta for all peaks
    zeta_inst = log(x_0/V_peaks(i + 1,1)) /(2 * pi * i); %Calculates zeta for instance
    zeta_arr(1,i) = zeta_inst; %Places zeta into array
end

zeta_avg = mean(zeta_arr) %Unsuppress output so that it displays to be recorded 

%% Plotting
figure('Name','Time Trace')
hold on
plot(t_mat,V_mat,'k-') % Plots Curve
plot(peak_loc,V_peaks,'vg','MarkerFaceColor','g') %Plots Peaks
xlabel('Time (s)')
ylabel('Output Voltage (V)')

legend('Voltage Curve','Peaks','Orientation','horizontal','Location','southeast')


