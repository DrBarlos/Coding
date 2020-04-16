%% Creates Bode Plot from Measurement Points

f = [250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000]; % Frequency vector 
p = [0.409 0.409 0.008 1.132 1.744 1.744 0.461 1.564 0.094 0.062 ...
    0.142 1.088 0.785 0.554 0.537 0.525]; % H or transfer ratio

%% Plotting

loglog(f,p,'ok','MarkerFaceColor','k')
xlabel('Frequency (Hz)')
ylabel('$A_{in}/A_{out}$','Interpreter','latex')
axis([min(f)-10 max(f)+10 min(p)-1000 max(p)+1])