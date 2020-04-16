function dxdt = odefun(t,x,eps)
dxdt = [-(x(2) + x(3)); 
    x(1) + 1/5 * x(2); 
    1/5 + (x(1) - eps) * x(3) ];
end
