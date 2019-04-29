function [ x ] = RungeKutta( ODE, dt, u, x0 )
% Runge-Kutta 4th Order Method

N = length(dt);
x = zeros( N+1, numel(x0) );
x(1, :) = x0;

for i = 1:N
    h = dt(i);
    
    U_mid = (u(i+1, :) - u(i, :))/2 + u(i, :);
    
    K1 = ODE( x(i, :)         , u(i, :) )';
    K2 = ODE( x(i, :) + K1*h/2, U_mid   )';
    K3 = ODE( x(i, :) + K2*h/2, U_mid   )';
    K4 = ODE( x(i, :) + K3*h  , u(i+1, :) )';
    
    x(i+1, :) =  x(i, :) + (h/6) * ( K1 + 2*K2 + 2*K3 + K4 );
end

end

