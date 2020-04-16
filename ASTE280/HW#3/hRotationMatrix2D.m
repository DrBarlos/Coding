function r = hRotationMatrix2D( theta )
%HROTATIONMATRIX2D Answer the 3x3 matrix that rotates a vector in
%homogeneous coordinates by angle theta (degrees)

r = eye(3,3); % Identity matrix

ct = cosd(theta);
st = sind(theta);

r(1:2,1:2) = [ ct, -st; st, ct ];
return;


