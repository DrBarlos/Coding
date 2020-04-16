R_e = 6378;
d_m = 384402;

x_lim = d_m;
y_lim = R_e+3e3;

mu_e = 3.986e5;
mu_m = 4.904e3;

m_1 = 384;

% V_E = @(x,y) (-(mu_e*m_1)/sqrt(x^2+y^2));
% V_M = @(x,y) (-(mu_e*m_1)/sqrt((x-d_m)^2+y^2));
V_t = @(x,y) (-(mu_e*m_1)/sqrt(x^2+y^2)) + (-(mu_m*m_1)/sqrt((x-d_m).^2+y.^2));

fsurf(V_t,[3e5 x_lim-1e4 -y_lim y_lim])

