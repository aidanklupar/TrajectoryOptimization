clc; clear; close all;

t = linspace(0, 20, 1000);

x  = zeros(size(t));
y  = zeros(size(t));
vx = zeros(size(t));
vy = zeros(size(t));

for i = 1:length(t)
    [ y_vec ] = initialConditions( t(i) );
    x(i)  = y_vec(1); 
    y(i)  = y_vec(2);
    vx(i) = y_vec(3);
    vy(i) = y_vec(4);
end

figure
hold on
plot(t, x);
plot(t, y);
title('Position')
grid on
grid minor

figure
hold on
plot(t, vx);
plot(t, vy);
title('Velocity')
grid on
grid minor

figure
plot(x, y)
axis equal
grid on
grid minor
