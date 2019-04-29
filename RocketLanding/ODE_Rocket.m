function [ dy_vec ] = ODE_Rocket( ~, y_vec, u )
g = 9.81;
m = 24000;

% States
x  = y_vec(1);
y  = y_vec(2);
vx = y_vec(3);
vy = y_vec(4);

% Inputs
TWR = u(1);
A   = u(2);

% Atmosphere and Drag Calculations
h_scale = 7650;
rho_ref = 1.225;
rho = rho_ref * exp(-y / h_scale);
Cd = 0.8;
S = 10.75;
D = 0.5 * rho * S * Cd * (vx^2 + vy^2);

FPA = atan2(vy, vx);
Dx = -D*cos(FPA) / m;
Dy = -D*sin(FPA) / m;

% State Derivatives
dy_vec = [ vx;
           vy;
          -TWR*g*sin(A) + Dx;
           TWR*g*cos(A) - g + Dy];

% Introduce nondimensional time
norm_tf = y_vec(5);      
dy_vec = norm_tf * [dy_vec; 0];

end

