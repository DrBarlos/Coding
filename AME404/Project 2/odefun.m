function dzdx = odefun(x,z)
global mu omega 
% Subfunction
d4 = mu*z(1)+omega*((-x*z(2))+(z(3)/2)-((z(3)*x^2)/2));

dzdx =[ z(2); 
    z(3); 
    z(4); 
    mu*z(1)+omega*((-x*z(2))+(z(3)/2)-((z(3)*x^2)/2));];
end 
        
       

