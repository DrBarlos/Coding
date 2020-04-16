%% HW #10 Numerical Stability 
clear

% Integration parameters
Nx=21;
Lx=1;
dt= 0.0005; 
Nt= 1/dt;
dx=Lx/(Nx-1);
x=dx*[0:Nx-1];
s=dt/dx^2;
% As s approaches 1/2, numerical solutions begin to appear jagged and
% broken. Lower s numbers guarantee stability, but come at the price of
% slow convergence. 

% Equation Parameters
mu = 0.5;
gamma = 1;
T_inf = 1.5;
T_0 = 1;

% Initial values
T(1:Nx) = T_0;
Tn=T; % temporary storage
t=0;

% Number of snapshots
N_shot=40;
N_inc=floor(Nt/N_shot);
figure
plot(x,T,'-','LineWidth',2)
% ylim([0 1])
xlabel('x'), ylabel('T')
timemarker = text(0.05,1.3,['t=',num2str(t)]);
sparam = text(0.05,1.25,['s=',num2str(s)]);
video = VideoWriter('FTCS.avi');
open(video)
pause

% Time integration
for n=1:Nt
 % Advance internal values
    for j=2:Nx-1
        % Calculating Subfunctions
        A = 0.18 * (1- mu * x(j));
        A_deriv = -0.18 * mu;
        l = 1.5 * sqrt(1 - mu*x(j));
        
        %Calculating Psuedocoefficients
        aj = dt/(dx^2) - 0.5 * ((A_deriv * dt) / (A * dx));
        bj = 1 - 2 * (dt/(dx^2)) - gamma * (l/A) * dt;
        cj = dt/(dx^2) + 0.5 * ((A_deriv * dt) / (A * dx));
        dj = gamma * (l/A) * T_inf * dt;
        
        % Calculate Equation
        T(j) = aj*Tn(j-1) + bj*Tn(j) + cj*Tn(j+1) + dj;
    end
    frame = getframe(gcf);
    writeVideo(video,frame);
    % Advance time and set Boundary values
    t=t+dt;
    % Initial boundary condition
    T(1) = T_0;
    
    % Endpoint boundary condition
    % Calculating Subfunctions
    ANx = 0.18 * (1- mu * x(Nx));
    A_derivNx = -0.18 * mu;
    lNx = 1.5 * sqrt(1 - mu * x(Nx));
        
    %Calculating Psuedocoefficients
    aNx = dt/(dx^2) - 0.5 * ((A_derivNx * dt) / (ANx * dx));
    bNx = 1 - 2 * (dt/(dx^2)) - gamma * (lNx/ANx) * dt;
    cNx = dt/(dx^2) + 0.5 *((A_derivNx * dt) / (ANx * dx));
    dNx = gamma * (lNx/ANx) * T_inf * dt;
    
    T(Nx) = (aNx + cNx) * Tn(Nx-1) + (bNx + 2*dx*gamma*cNx)*T(Nx) - 2*cNx*dx*gamma*T_inf + dNx; 
    % Store solution in temporary array
    Tn=T;
    % Take a snapshot every N_inc steps
    if mod(n,N_inc)== 0
        delete(timemarker)
        hold on
        plot(x,T,'-','LineWidth',2)
        xlabel('x'), ylabel('T')
        timemarker = text(0.05,1.3,['t=',num2str(t)]);
        sparam = text(0.05,1.25,['s=',num2str(s)]);
        pause(0.05)
    end
end

close(video);