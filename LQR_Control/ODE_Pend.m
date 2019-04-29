function [ dy_vec ] = ODE_Pend( t, y_vec, K, xe, ue, t_eq )
% States
T  = y_vec(1);
dT = y_vec(2);

% Get input from K vector
u = LQR_Controller( K, y_vec, xe, ue, t_eq, t );

% State Derivatives
dy_vec = [dT;
         -sin(T) + u];

end

