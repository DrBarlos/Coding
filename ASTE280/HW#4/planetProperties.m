% Creates Planet List using...
% 1 AU = 1.492e+8
conv = 1.492 * 10^8; % Creates conversion ratio from AU to km
planets = ['Venus', 'Mars', 'Saturn'];
planet_num = 3;
mu_sun = 1.327 * 10^11;
mu_arr = mu_sun * ones(1,planet_num);
radius_au = [0.7233, 1.524, 5.203]; % Creates vector of planet distances
radius = radius_au * conv;
[v, Tv] = orbitCirc(radius, mu_arr);
for i = 1:planet_num
    fprintf('%s orbits around the sun with speed %.3f and period %.3f seconds. \n', planets(i), v(i), Tv(i))
end