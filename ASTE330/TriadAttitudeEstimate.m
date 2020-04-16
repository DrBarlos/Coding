function Rbi = TriadAttitudeEstimate( w1, w2, v1, v2 )
%TRIADATTITUDEESTIMATE Find the spacecraft attitude 
% from two single-axis measurements using the triad method
% from two single-axis measurements using the triad method
% from two single-axis measurements using the triad method
% Inputs: 
%w1, w2: Body-fixed measurement vectors (1x3)
%v1, v2: Inertial vectors (1x3)
% Output:
%Rbi: Body-fixed to inertial transformation matrix

%% Defining Preliminary variables
%Inertial Vectors
r1h = v1;
r2h = cross(v1,v2)/norm(cross(v1,v2));
r3h = cross(r1h,r2h);

%Body-fixed vectors
s1h = w1;
s2h = cross(w1,w2)/norm(cross(w1,w2));
s3h = cross(s1h,s2h);

%Creating Matrices
A = [s1h',s2h',s3h'];
B = [r1h',r2h',r3h'];

%% Calculation of Transformation Matrix
Rbi = B * A'