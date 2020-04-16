theta = -180:180;
r_planets = [0.3871, 0.7233, 1.0000, 1.524, 5.203, 9.539, 19.18, 39.44];

% planet 1
x1 = r_planets(1) * cosd(theta);
y1 = r_planets(1) * sind(theta);

% planet 2
x2 = r_planets(2) * cosd(theta);
y2 = r_planets(2) * sind(theta);

% planet 3
x3 = r_planets(3) * cosd(theta);
y3 = r_planets(3) * sind(theta);

% planet 4
x4 = r_planets(4) * cosd(theta);
y4 = r_planets(4) * sind(theta);

% planet 5
x5 = r_planets(5) * cosd(theta);
y5 = r_planets(5) * sind(theta);

% planet 6
x6 = r_planets(6) * cosd(theta);
y6 = r_planets(6) * sind(theta);

% planet 7
x7 = r_planets(7) * cosd(theta);
y7 = r_planets(7) * sind(theta);

% planet 8
x8 = r_planets(8) * cosd(theta);
y8 = r_planets(8) * sind(theta);

% planet 9
x9 = r_planets(9) * cosd(theta);
y9 = r_planets(9) * sind(theta);

figure
hold on
plot(x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8,x9,y9)