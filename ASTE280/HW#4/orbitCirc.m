% Defines function to calculate circular orbits and returns velocity and
% period
function [ v, T ] = orbitCirc(r, mu)
v = sqrt(mu./r);
T = 2*pi.*r./v;
end

