function [ y_vec ] = shoot( decVars, t )
ODE = @ODE_Rocket;

% Get Inputs
[ u, tf, ts ] = getInputs( decVars  );
[ y0 ] = initialConditions( ts );
y0(end) = tf;

% Intergrate Equations of Motion
y_vec = RungeKutta( ODE, t, u, y0);

end

