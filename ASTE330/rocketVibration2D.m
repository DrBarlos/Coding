function [modeShapes,freqs] = rocketVibration2D( useMoreRealisticValues )

% Like rocketVibration, but look at 2D oscillations

if nargin > 0  &&  useMoreRealisticValues

  m = [ 1000, 200, 10 ]; % Oxidizer, fuel, payload masses
  h = [ 1.5, 1.5, 0.5 ]; % Heights
  w = [ 0.5, 0.5, 0.25 ]; % Widths
  k = [ 1e7, 1e5 ]; % Spring constants of the members of the two trusses

else

  % For testing: Use nominal values
  m = [1,1,1];

  h = [1,1,1];
  w = [1,1,1];
  k = [ 1000, 1000 ];

end

% Moments of inertia -- assume uniform rectangles
I = (m/12) .* ( h.^2 + w.^2 );

% Order of variables in matrices:
% x1, y1, theta1, x2, y2, theta2, x3, y3, theta3

% Diagonal mass matrix
M = diag( [m(1), m(1), I(1), m(2), m(2), I(2), m(3), m(3), I(3) ] );

K = zeros(9,9); % Stiffness matrix

% Truss 1 connects masses 1 and 2; truss 2 connects masses 2 and 3
for i=1:2 % loop over trusses
  xi = 3*i - 2; % index of x_i
  yi = xi + 1; % index of y_i
  ti = xi + 2; % index of theta_i
  xj = xi + 3; % index of x_{i+1}
  yj = xi + 4; % index of y_{i+1}
  tj = xi + 5; % index of z_{i+1}
  
  % x(i), x(i+1) affected by x(i), x(i+1) (sideways forces)
  D = k(i);
  K(xi,xi) = K(xi,xi) - D;
  K(xj,xi) = K(xj,xi) + D;
  K(xj,xj) = K(xj,xj) - D;
  K(xi,xj) = K(xi,xj) + D;

  % x(i), x(i+1) affected by theta(i), theta(i+1) (sideways forces)
  D = k(i)*h(i)/2;
  K(xi,ti) = K(xi,ti) - D;
  K(xj,ti) = K(xj,ti) + D;
  D = k(i)*h(i+1)/2;
  K(xi,tj) = K(xi,tj) - D;
  K(xj,tj) = K(xj,tj) + D;
  
  % y(i), y(i+1) affected by y(i), y(i+1) (axial forces)
  D = 3*k(i);
  K(yi,yi) = K(yi,yi) - D;
  K(yj,yi) = K(yj,yi) + D;
  K(yj,yj) = K(yj,yj) - D;
  K(yi,yj) = K(yi,yj) + D;
  
  % theta(i), theta(i+1) affected by x(i), x(i+1)
  Di = k(i)*h(i)/2;
  Dj = k(i)*h(i+1)/2;
  K(ti,xi) = K(ti,xi) - Di;
  K(tj,xi) = K(tj,xi) - Dj;
  K(tj,xj) = K(tj,xj) + Dj;
  K(ti,xj) = K(ti,xj) + Di;
  
  % theta(i), theta(i+1) affected by theta(i), theta(i+1)
  Dw = 3*k(i) * (w(i+1)/4)^2;
  K(ti,ti) = K(ti,ti) - k(i) * (h(i)/2)^2 - Dw;
  K(tj,ti) = K(tj,ti) - k(i) * (h(i+1)/2)*(h(i)/2) + Dw;
  K(tj,tj) = K(tj,tj) - k(i) * (h(i+1)/2)^2 - Dw;
  K(ti,tj) = K(ti,tj) - k(i) * (h(i+1)/2)*(h(i)/2) + Dw;
end
  
K = -K;

A = inv(M) * K;

[ modeShapes, d ] = eig( A )
modeShapes = real(modeShapes);

freqs = real( sqrt( diag(d)' ) ) / (2*pi);

    




    
