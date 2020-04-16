%% Latitude and longitude
venus = [0.728249972994* cosd(311.9751), 0.728249972994 * sind(311.9751) ];
earth = [0.984369557831  * cosd(123.6876), 0.984369557831 * sind(123.6876)];
mars = [1.610590611620 * cosd(204.3960), 1.61059061162 * sind(204.3960)];
jupiter = [5.4286 * cosd(220.0663),5.4286 * sind(220.0663)];
saturn = [10.06509057683 * cosd(270.9519), 10.06509057683 * sind(270.9519)];
sun = [0,0];


%% Plotting Section
figure
hold on
planets = scatter(sun(1),sun(2), 200,'y','filled');
scatter(venus(1),venus(2),30,[0.9, 0.1, 0],'filled');
scatter(earth(1),earth(2),36,'b','filled');
scatter(mars(1),mars(2),33, 'r','filled');
scatter(jupiter(1), jupiter(2), 80, [0.9, 0.1, 0], 'filled');
scatter(saturn(1),saturn(2), 50, [1, 0.95, 0], 'filled');

plot([sun(1), venus(1)],[sun(2), venus(2)],'--', 'Color', [0.9, 0.1, 0]);
plot([sun(1), earth(1)],[sun(2), earth(2)],'b--');
plot([sun(1), mars(1)],[sun(2), mars(2)],'r--');
plot([sun(1), jupiter(1)],[sun(2), jupiter(2)],'--','Color',[0.9, 0.1, 0]);
plot([sun(1), saturn(1)],[sun(2), saturn(2)], '--', 'Color', [1, 0.95, 0]);

title('Holst - The Planets');
legend('Sun','Venus - Bringer of Peace','Earth','Mars - Bringer of War','Jupiter - Bringer of Jollity','Saturn - Bringer of Old Age', 'Location','northeast');
axis([-11, 11, -11, 11])
set(gca,'Color','k')
