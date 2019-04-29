function [ y_vec ] = shoot( decVars, t, y0 )
ODE = @ODE_Rocket;

% Get Inputs and set final time
[ u, tf ] = getInputs( decVars  );
y0(end) = tf;

% Run Simulation
y_vec = RungeKutta( ODE, t, u, y0);

end

