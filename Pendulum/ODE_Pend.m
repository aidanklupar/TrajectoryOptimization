function [ dy_vec ] = ODE_Pend( y_vec, u )

T  = y_vec(1);
dT = y_vec(2);

dy_vec = [dT;
         -sin(T) + u];

norm_tf = y_vec(3);
dy_vec = norm_tf * [dy_vec; 0];

end

