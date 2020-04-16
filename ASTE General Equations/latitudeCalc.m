%% Setup
div = 5; % Intervals we want to increment from zero to final value
loMax = 90; % Maximum longitude
n = (loMax/div)+ 1; % Calculates cardinality of values based off interval divsion count
lon = linspace(0,90,n); % Creates longitude array counting in 5 degree interval starting from 0 and ending at 90
az = 45; % Specifies azimuth angle
beta = 90 - az; % Calculates complementary angle for spherical triangle
gamma = 90; % Through definition of latitude and longitude being perpendicular
lat = zeros(1,n); % Initializes latitude array, prefilled with zeros


%% Calculation
for i = 1:n
    alpha = acosd(sind(beta)*sind(gamma)*cosd(lon(i)) - cosd(beta)*cosd(gamma)); % Calculates alpha for term i of lon
    lat(i) = asind((sind(lon(i))/sind(alpha))*sind(beta)); % Calculates latitude for term i of lon
end

%% Plot
latLot = plot(lon,lat) % Creates plot
line([0,22.5],[0,22.5]);