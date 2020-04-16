function r = hRotationMatrixZ( theta )
%HROTATIONMATRIXZ Answer the 4x4 matrix that rotates a vector in
%homogeneous coordinates about z by angle theta (degrees)

r = eye(4,4); % Identity matrix

ct = cosd(theta);
st = sind(theta);

r(1:2,1:2) = [ ct, -st; st, ct ];
return;


