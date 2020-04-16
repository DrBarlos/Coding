function phi = odefun(x,y)

% Constants
q = 1e5;
EI = 1.4e7;
L = 10;

% Function Def
phi = [ y(2);
    1/EI * q/2 * (L * x - x^2 ) * (1 + y(2)^2).^(3/2) ];
end

