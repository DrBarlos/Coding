function [b] = c2b(c,rho,M)
%% Molarity to Molality Converter
%{
-------------------------------
By Carlos A. Sanchez and Daniel Silva
This code takes in molarity values and converts them to molality via the
use of the appropriate molal values from solution mass density
Def of Variables:
rho is taken to be in units of kg/m^3
M is molar mass in units of g/mol
%}
%% Calculation
b = c ./ (rho - c*M / 1000); %Changes units from molarity to molality
end

