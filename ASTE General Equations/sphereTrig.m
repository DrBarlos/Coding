function [d, Az, i] = sphereTrig( La1, Lo1, La2, Lo2 )
%% Setup of Variables
% Where (La1, Lo1) , (La2, Lo2) are latitude and longitude pairs respectively
Re = 6371; % Where Re is radius of earth
a = 90 - La1; % Where a is length of one side of triangle
b = 90 - La2; % Where b is length of side of triangle 
gamma = Lo2 - Lo1; % Where gamma is angle between a and b
if (Lo1-Lo2) > gamma

%% Calculations
c = acosd(cosd(a) * cosd(b) + sind(a) * sind(b) * cosd(gamma)); % Gives distance in degrees
d = 2 * pi * Re *( c / 360); % Gives distance in km
Az = asind( sind(b) * sind(gamma)/sind(c)); % Gives azimuth
i = acosd(cosd(La1)* sind(Az)); % Gives inclination of flight
if La1 > La2
    i = i - pi;
end
%% Printing to Screen 
fprintf('The distance of this flight is %.2f km\n', d)
fprintf('The azimuth is %.2f degrees from the north\n', Az)
fprintf('The inclination is %.2f degrees from equator\n', i)
end

