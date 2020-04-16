r_i = [1;0;0];
rdot_i = [0;0;0];
r_state_i = [r_i; rdot_i];

t_span = [0,100];

[t,r_state] = ode45(@fun,t_span,r_state_i);

plot3(r_state(:,1),r_state(:,2),r_state(:,3))

function dydx = fun(t,r_state)
q = 1;
m = 1;

dydx = ...
    [r_state(4);
    r_state(5);
    r_state(6);
    q/m*(1-r_state(6));
    0;
    q/m*r_state(4);
    ];
end
