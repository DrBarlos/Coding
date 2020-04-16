%% Creating Wave Phase Signal and Data Plot

%% Adding Data
% 600 Hz Signal
x = [ 0, 8.7, 12.2, 12.2, 42.6, 52.2, 66.1, 71.7,71.7]; % Distance from end of tube
phs = [pi, 3 * pi/2, 2 * pi, 0, pi/2, pi, 3*pi/2, 2* pi, 0 ]; % Phase from time trace shifter by pi (for inverting op amp)

error = 0.5; % Limitation of using meter stick (in cm)
error_x =  error * ones(1,length(x));

% 1200 Hz Signal
x1 = [0, 12, 12, 16, 26.8, 41.5, 45.1, 45.1, 55.4, 69.7, 73]; % Distance from end of tube
phs1 = [3 * pi/2, 2* pi, 0, pi/2, pi, 3 * pi/2, 2* pi, 0, pi/2, pi, 3* pi/2]; %Phase from time trace shifted by pi (for inverting op amp)

error1 = 0.5; % Limitation of using meter stick (in cm)
error_x1 =  error1 * ones(1,length(x1));
%% Plotting
% 600 Hz
figure(1)

hold on
errorbar(x, phs, error_x, 'horizontal', '.k')
p1 = line([x(1),x(6)], [phs(1), phs(6)],'LineStyle','--')
line([x(2),x(7)], [phs(2), phs(7)],'LineStyle','--')
line([x(3),x(8)], [phs(3), phs(8)],'LineStyle','--')
line([x(4),x(9)], [phs(4), phs(9)],'LineStyle','--')
hold off

xlabel('x (cm)')
ylabel('\phi (rads)')
axis([-5, 75, -1, 7.5])
legend(p1, 'Sound Wavelength')
set(gca,'YTick', 0:pi/2:2*pi)
set(gca,'YTickLabel', {'0','^{\pi}/_{2}','\pi','^{3 \pi}/_{2}','2\pi'})

% 1200 Hz
figure(2)

hold on
errorbar(x1, phs1, error_x1, 'horizontal', '.k')
p2 = line([x1(1),x1(6)], [phs1(1), phs1(6)],'LineStyle','--')
line([x1(2),x1(7)], [phs1(2), phs1(7)],'LineStyle','--')
line([x1(3),x1(8)], [phs1(3), phs1(8)],'LineStyle','--')
line([x1(4),x1(9)], [phs1(4), phs1(9)],'LineStyle','--')
line([x1(5),x1(10)], [phs1(5), phs1(10)],'LineStyle','--')
hold off

xlabel('x (cm)')
ylabel('\phi (rads)')
axis([-5, 75, -1, 7.5])
legend(p2, 'Sound Wavelength')
set(gca,'YTick', 0:pi/2:2*pi)
set(gca,'YTickLabel', {'0','^{\pi}/_{2}','\pi','^{3 \pi}/_{2}','2\pi'})