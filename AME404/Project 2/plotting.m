%% Plotting
figure()
plot(xm1,zm1,xm2,zm2,xm3,zm3);
xlabel('x'), ylabel('z');
axis auto
legend({'Mode 1', 'Mode 2', 'Mode 3'}, 'Location', 'southwest')
title('Modal Eigenfunctions of Omega Squared at 400')