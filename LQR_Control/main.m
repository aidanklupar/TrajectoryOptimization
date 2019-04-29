clc; clear; close all;

% Get Trajectory
load('OptimalControl_MinTime.mat')
%load('OptimalControl_MinInput.mat')

% Get Optimal K matrix
[ K ] = getLQR( x_eq );

% Integrate ODE
y0 = [0; 0];
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8);
[t, y_vec] = ode45(@(t, y) ODE_Pend( t, y, K, x_eq, u_eq, t_eq ), t_eq, y0, options);

% Extend ODE past final time along desired final point
[t_ext, y_ext] = ode45(@(t, y) ODE_Pend( t, y, K(end, :), x_eq(end, :), 0, t_eq(end, :) ), [t_eq(end):0.5:t_eq(end)+5], y_vec(end, :));

% Merge trajectory and extended trajectories
t = [t; t_ext(2:end)];
t_eq = [t_eq; t_ext(2:end)];
y_vec = [y_vec; y_ext(2:end, :)];
x_eq = [x_eq; x_eq(end, :).*ones(length(t_ext(2:end)), 2)];
K = [K; K(end, :).*ones(length(t_ext(2:end)), 2)];
u_eq = [u_eq; zeros(length(t_ext(2:end)), 1)];

% Get States
T  = y_vec(:, 1);
dT = y_vec(:, 2);

%% Angle & Angular Velocity
figure
subplot(1, 2, 1)
hold on
title('Pendulum Angle')
plot(t, rad2deg(T), '-x')
plot(t_eq, rad2deg(x_eq(:, 1)), '--o')
xlabel('Time [s]')
ylabel('Pendulum Angle [deg]')
legend('Desired Trajectory', 'Actual Trajectory', 'Location', 'best')
grid on
grid minor

subplot(1, 2, 2)
hold on
title('Angular Velocity')
plot(t, rad2deg(dT), '-x')
plot(t_eq, rad2deg(x_eq(:, 2)), '--o')
xlabel('Time [s]')
ylabel('Pendulum Angular Velocity [deg/s]')
legend('Desired Trajectory', 'Actual Trajectory', 'Location', 'best')
grid on
grid minor

%% Error
figure
subplot(1, 2, 1)
hold on
title('Angular Error')
plot(t, rad2deg(T - x_eq(:, 1)), '-x')
xlabel('Time [s]')
ylabel('Pendulum Angular Error [deg]')
grid on
grid minor

subplot(1, 2, 2)
hold on
title('Angular Velocity Error')
plot(t, rad2deg(dT - x_eq(:, 2)), '-x')
xlabel('Time [s]')
ylabel('Pendulum Angular Velocity Error [deg]')
grid on
grid minor

%% Control Input
u = zeros(size(t));
for i = 1:length(t)
    u(i) = LQR_Controller( K, y_vec(i, :)', x_eq, u_eq, t_eq, t(i) );
end

figure
hold on
plot(t, u_eq, '-x')
plot(t, u, '--o')
xlabel('Time [s]')
ylabel('Input Moment [N]')
title('Control Input')
legend('Desired Inpuet', 'Actual Input', 'Location', 'best')
grid on
grid minor