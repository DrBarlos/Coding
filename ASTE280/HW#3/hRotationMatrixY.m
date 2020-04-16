function r = hRotationMatrixY( theta )
%HROTATIONMATRIXY Answer the 4x4 matrix that rotates a vector in
%homogeneous coordinates about y by angle theta (degrees)

r = eye(4,4); % Identity matrix

ct = cosd(theta);
st = sind(theta);

r(1:2:3,1:2:3) = [ ct, st; -st, ct ];
return;


