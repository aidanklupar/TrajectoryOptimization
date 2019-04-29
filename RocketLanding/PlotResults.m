clc; clear; close all;

load('OptControl_MinTime.mat')

[u, tf, ts] = getInputs(decVars);
t = linspace(0, 1, length(u));

y_vec = shoot( decVars, t );

x   = y_vec(1, :);
y   = y_vec(2, :);
v_x = y_vec(3, :);
v_y = y_vec(4, :);
t   = t * tf;
 
F = u(1, :);
A = u(2, :);

% Convert to Actual Thrust [kN]
%F = F*24*9.81;

% Convert to Percent Max Thrust
F = 100 * F / 2;

%% Input Plots
figure
hold on
title('Rocket Control Inputs')
yyaxis left
plot(t, F, '-o')
%ylabel('Thrust [kN]')
ylabel('Percent Max Thrust [%]')
axis([0 t(end) 0 1.1*max(F)])

yyaxis right
plot(t, rad2deg(A), '-o')
ylabel('Thrust Angle [deg]')
axis([0 t(end) -17 17])

xlabel('Time [s]')
legend('Thrust Force', 'Thrust Angle', 'Location', 'best')
grid on
grid minor

%% Rocket Trajectory
figure 
hold on
plot(x/1000, y/1000, '-o')
plot(x(1)*ones(size(x))/1000, y/1000, 'b--')
title('Rocket Landing Trajectory')
xlabel('DownRange [km]')
ylabel('Altitude [km]')
legend('Actual Trajectory', 'No Burn Trajectory', 'Location', 'best')
grid on
grid minor
axis equal

%% Trajectory Close up
figure 
hold on
plot(x(end-10:end), y(end-10:end), '-o')
title({'Rocket Landing Trajectory'; 'No Horizontal Velocity Constraint'})
xlabel('DownRange [m]')
ylabel('Altitude [m]')
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

%% FPA Plot
figure
hold on
title({'FPA Time History'; 'Horizontal Velocity Constraint'})
plot(t(1:end-1), atand(v_y(1:end-1) ./ v_x(1:end-1)), '-o')
xlabel('Time [s]')
ylabel('FPA [deg]')
grid on
grid minor