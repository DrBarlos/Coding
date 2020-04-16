function r = hRotationMatrixX( theta )
%HROTATIONMATRIXX Answer the 4x4 matrix that rotates a vector in
%homogeneous coordinates about x by angle theta (degrees)

r = eye(4,4); % Identity matrix

ct = cosd(theta);
st = sind(theta);

r(2:3,2:3) = [ ct, -st; st, ct ];
return;


