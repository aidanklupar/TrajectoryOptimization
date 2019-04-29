function [ y ] = RungeKutta( ODE, t, u, y0 )
% Runge-Kutta 4th Order Method

N = length(t);
y = zeros(length(y0), N);
y(:, 1) = y0;

for i = 1:N-1
    h = t(i+1) - t(i);
    
    U_mid = (u(:, i+1) - u(:, i))/2 + u(:, i);
    
    K1 = ODE( t(i),       y(:, i)         , u(:, i)   );
    K2 = ODE( t(i) + h/2, y(:, i) + K1*h/2, U_mid  );
    K3 = ODE( t(i) + h/2, y(:, i) + K2*h/2, U_mid  );
    K4 = ODE( t(i) + h,   y(:, i) + K3*h  , u(:, i+1) );
    
    y(:, i+1) =  y(:, i) + (h/6) * ( K1 + 2*K2 + 2*K3 + K4 );
end

end

