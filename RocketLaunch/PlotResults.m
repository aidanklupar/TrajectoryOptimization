%load('OptControl_MaxFuel_05_7600.mat')

y0 = [0; 0; 0; 0; 24000 + 395700; 100];
[u, tf] = getInputs(decVars);
t = linspace(0, 1, length(u));

y_vec = shoot( decVars, t, y0 );

x   = y_vec(1, :);
y   = y_vec(2, :);
v_x = y_vec(3, :);
v_y = y_vec(4, :);
mf  = y_vec(5, :) - 24000;
t   = t * tf;
 
F = u(1, :);
A = u(2, :);

% Convert to Percent Max Thrust
%F = 100 * F / 7600000;

%% Input Plots
figure
hold on
title('Rocket Control Inputs')
yyaxis left
plot(t, F, '-o')
ylabel('Thrust [kN]')
axis([0 t(end) 0 1.1*max(F)])

yyaxis right
plot(t, rad2deg(A), '-o')
ylabel('Thrust Angle [deg]')
axis([0 t(end) -1.1*max(abs(rad2deg(A))) 1.1*max(abs(rad2deg(A)))])

xlabel('Time [s]')
legend('Thrust Force', 'Thrust Angle', 'Location', 'best')
grid on
grid minor

%% Rocket Trajectory
figure 
hold on
plot(x/1000, y/1000, '-o')
title('Rocket Launch Trajectory')
xlabel('DownRange [km]')
ylabel('Altitude [km]')
grid on
grid minor
axis equal

%% Position Time History Plot
figure
hold on
plot(t, x/1000, '-o')
plot(t, y/1000, '-o')
title('Rocket Position Time History')
legend('DownRange', 'Altitude', 'Location', 'best')
xlabel('Time [s]')
ylabel('Position [km]')
grid on
grid minor

%% Velocity Time History Plot
figure
hold on
title('Rocket Velocity Time History')
plot(t, v_x, '-o')
plot(t, v_y, '-o')
legend('V_X', 'V_Y', 'Location', 'best')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
grid on
grid minor

%% Flight Path Angle
figure
hold on
title('Flight Path Angle Time History')
plot(t, atand(v_y ./ v_x), '-o')
xlabel('Time [s]')
ylabel('Flight Path Angle [deg]')
grid on
grid minor

%% Fuel Mass
figure
hold on
title('Fuel Mass Time History')
plot(t, mf / 1000, '-o')
xlabel('Time [s]')
ylabel('Mass of Fuel Remaining [tonnes]')
grid on
grid minor