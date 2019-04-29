function [ dy_vec ] = ODE_Rocket( ~, y_vec, u )
g = 9.81; 
Isp = 300;

% States
x  = y_vec(1);
y  = y_vec(2);
vx = y_vec(3);
vy = y_vec(4);
m  = y_vec(5);

% Inputs
F = u(1);
A = u(2);

% Helps prevents Numerical issues due to poor controls
if m < 24000
    m = 24000;
end
if y < 0
    y = 0;
end

% Rocket Thrust to Weight Ratio and Mass Flow
TWR = F / (m*g);
dm  = F / (Isp * g);

% Atmosphere and Drag Calculations
h_scale = 7650;
rho_ref = 1.225;
rho = rho_ref * exp(-y / h_scale);
Cd = 0.5;
S = 10.75;
D = 0.5 * rho * S * Cd * (vx^2 + vy^2);

FPA = atan2(vy, vx);
Dx = -D*cos(FPA) / m;
Dy = -D*sin(FPA) / m;

% Equations of Motion
dy_vec = [ vx;
           vy;
          -TWR*g*sin(A) + Dx;
           TWR*g*cos(A) - g + Dy;
           -dm];

% Introduce nondimensional time for better numerical analysis
norm_tf = y_vec(6);      
dy_vec = norm_tf * [dy_vec; 0];

end

