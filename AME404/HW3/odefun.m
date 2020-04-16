function dxdt= odefun(t,u,a,theta, theta_dot)
g = 9.81;

dxdt = [xu * u + xa * a - g * theta; ...
    (zu/u0)* u + (za/zu) * a + (1 + (zq/u0)* theta_dot + (zd/u0)* delta_dirac(t)); ...
    (mad + (mad * zq /u0) + mq) * theta_dot + ((mad * zu/u0)+ mu) * u + ((mad * za/u0) + ma) * a + ((mad * zd /u0) + md) * delta_dirac(t)];

    function f = delta_dirac(t)
        if t > 0
            f = 0.1;
        else
            f = 0;
        end
    end
end

