%% Operational Amplifier Bode Plot Creator
%{
by Carlos Sanchez
-----------------------------
Creates Real and Ideal Bode Plots from ei, eo, f,
r1,r2,del_ei,del_eo,f0,f_unity

Assuming a perfect function generator. 

ei specifies incoming voltage signal array
eo specifies voltage system response 
del_ei specified incoming voltage signal errors
del_eo specified voltage system response errors
f frequency signal is recorded at
r1 resistance outside feedback loop
r2 resistance in feedback loop
f0 measured cutoff frequency
f_unity measured unity gain frequency 

%}


%% Calculations
%System Properties
G = r2/r1; % Calculation of system gain

% Real Measurements
H_abs = eo ./ ei; % Calculation of real frequency response magnitude
d_H = sqrt(((del_eo .* ( 1 ./ eo )) .^2) + ((del_ei .* (eo ./ (ei .^2) )) .^2) ); % Calculation of real magnitude uncertainty
delta_H = round(20 * 0.434 * d_H./ H_abs,1,'significant'); % Relative error for log. Taken from Taylor's Intro to Error Analysis
% Unique Points
f_unity = f(end);
H_unity = H_abs(end);

%GBP
GBP = G * f0 %Definition of GBP


%Ideal Model
A_div_mu = 2*pi*f0*(r2/r1); %Via back calculation of A/mu from cutoff frequency
f_ideal = linspace(1,1e6,1000000);
H_idealdb = 20*(log10(r2/r1)-log10(sqrt(1+(f_ideal*2*pi).^2 * ((r2/r1) *(1/A_div_mu))^2))); %Ideal Opamp Model

%% Plotting
figure()
hold on
vl = line((f0*ones(1,100000)),linspace(1,20*log10(0.707*G),100000),'Linestyle','--');
v2 = line(linspace(1,f0), 20*log10(0.707*G*ones(1,100)),'Linestyle','--');
pt = scatter(f0,20*log10(0.707*G),200,'k.');
id = plot(f_ideal,H_idealdb,'g');
rd = errorbar([f],[20*log10(H_abs)],delta_H,'vertical','.','MarkerSize',10,'MarkerEdgeColor','red','MarkerFaceColor','red');
ug = scatter(f_unity,H_unity,'b*');
gbp = line([f0,f_unity],[20*log10(0.707*G),1],'LineStyle','-.');
set(gca,'xscale','log');
set(gca,'yscale','log');
ylabel('|H| (dB)');
xlabel('Frequency f (Hz)');
axis auto
legend([rd,ug,pt,id,gbp],{'Measured Data Points','Measured Unity Gain','Measured Cutoff Frequency','Ideal Model','GBP'},'Location','southwest');
