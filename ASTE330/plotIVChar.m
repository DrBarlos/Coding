function plotIVChar(voc28,jsc28,vmp28,jmp28,T,mytitle)
%PlotIVChar provides IV characteristic plot for different solar panels
%based off their temperature coefficients (assuming a linear relationship
%between temperature and this.
%% Equations
voc = 3.94 + voc28 .* (T-28)
jsc = 120 + jsc28 .* (T-28)
vmp = 3.53 + vmp28 .* (T-28)
jmp = 115 + jmp28 .* (T-28)

c2 = ((vmp./voc) -1)/ (log10(1-(jmp ./jsc)))
c1 = (1-(jmp./jsc))* exp(-vmp./(c2.*voc))

V = [0:0.001:20]

% Assume 2 cm by 2cm cell thus
I = 0.0004 * jsc *(1 - c1*( exp( V ./ (c2 * voc) ) -1 ))
%% Plot

semilogy(V,I)
title(mytitle)
xlabel('V (volts)')
ylabel('I(amperes)')
end

