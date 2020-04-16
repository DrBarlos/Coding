function [omegaAB,q_A, q_B, multA , multB] = EinsteinSolid(N_A,N_B, q_tot, plotYes, q_lim)
%% Einstein Solid by Carlos Sanchez
%{
This program computes for all states, and will include limiter if specified
%}
switch nargin
    case 4 % q_lim is not used, will run for all energy levels (May crash if cases are too much)
        MS = q_tot + 1;
        q_A = 0:q_tot;
        q_B = q_tot - q_A;
        multA = ones(1,length(q_A));
        multB = ones(1,length(q_B));
    case 5 % if q_lim is specified
        MS = q_tot + 1;
        q_A = 0:q_lim;
        q_B = q_tot - q_A;
        multA = ones(1,length(q_A));
        multB = ones(1,length(q_B));
end
for i = 1:length(q_A)
    multA(i) = nchoosek( q_A(i) + N_A - 1, q_A(i));
    multB(i) = nchoosek( q_B(i) + N_B - 1, q_B(i));
end
    
omegaAB = multA .* multB;

if plotYes == true
    subplot(1,2,1)
    bar(q_A, omegaAB)
    xlabel('Energy Level')
    ylabel('# of Microstates')
    
    subplot(1,2,2)
    semilogy(q_A, omegaAB, 'o')
    xlabel('Energy Level')
    ylabel('log of # of Microstates')
    
end
        
end

