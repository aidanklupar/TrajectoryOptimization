function [ x_vec ] = shoot( u, dt, x0)
ODE = @ODE_Pend;

x_vec = RungeKutta( ODE, dt, u, x0 );

end

