function [ y0 ] = initialConditions( t )

y0 = [ -200; 4000; 0; -300; t];
[~, y_vec] = ode45(@(t, y) ODE_Rocket(t, y, [0 0]), [0, 1], y0);
y0 = y_vec(end, :);

end

