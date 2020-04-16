function dhdt = odefun(t,h,Q_in); % Define class of function

% Parameters
R = 2;
%Inhomogenous function
dhdt = (Q_in)/ (pi * h *(2*R -h));
end


