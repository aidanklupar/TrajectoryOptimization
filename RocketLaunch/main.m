clc; close all;

% Optimization Options
MaxIter   = 100;   % Maximum number of Iterations
OptTol    = 1e-6;  % Optimality Tolerance
ConTol    = 1e-6;  % Constraint Tolerance
StepTol   = 1e-6;  % Step Tolerance
Grad      = false; % Gradient Supplied by minimization function?
checkGrad = true;  % Check gradient supplied with numerical methods?

% Number of Data Points
N = 41;

% Number of States and Inputs
numStates = 6;
numInputs = 2;

% Input Constraints
F_max =  7600 * 1000;
F_min =  0.6*F_max;

A_min = -pi/2;
A_max =  pi/2;

% Initial & Final Conditions
tf0 = 150;
%    [ x; y; vx; vy;              m; tf0]
y0 = [ 0; 0;  0;  0; 24000 + 395700; tf0];
yf = [ 0; 65000; 1400; 1400; 24000 + 395700; tf0];

% Create solution arrays
t = linspace(0, 1, N);
u = [F_max*ones(1, N); 0*ones(1, N)];

% Get decision variables
decVars = getDecVars( u, tf0 );

% Set Upper Bounds and Lower Bounds
Ub = [F_max * ones(1, N), A_max * ones(1, N), 150];
Lb = [F_min * ones(1, N), A_min * ones(1, N), 50];

% Find optimal control
func     = @(decVars) FuncObjective(decVars, t, y0);
confunc  = @(decVars) FuncConstraint(decVars, t, y0, yf);

options = optimoptions('fmincon', 'Display', 'iter', 'SpecifyObjectiveGradient', Grad, 'MaxFunctionEvaluations', 1e10, 'MaxIterations', MaxIter, 'OptimalityTolerance', OptTol, 'ConstraintTolerance', ConTol, 'CheckGradients', checkGrad, 'StepTolerance', StepTol);
decVars = fmincon( func, decVars, [], [], [], [], Lb, Ub, confunc, options);

% Run Optimal Control and Print Results
[u, tf] = getInputs(decVars);
y_vec = shoot( decVars, t, y0 );

x   = y_vec(1, :);
y   = y_vec(2, :);
v_x = y_vec(3, :);
v_y = y_vec(4, :);
mf  = y_vec(5, :) - 24000;
t = t * tf;

F = u(1, :);
A = u(2, :);

%% Positions
figure
hold on
plot(t, x/1000, '-o')
plot(t, y/1000, '-o')
title('Positions')
xlabel('t')
legend('x', 'y')
grid on
grid minor

%% Velocities
figure
hold on
title('Velocities')
plot(t, v_x/1000, '-o')
plot(t, v_y/1000, '-o')
xlabel('t')
legend('v_x', 'v_y')
grid on
grid minor

%% Inputs
figure
hold on
title('Inputs')
plot(t, F / F_max, '-o')
plot(t, A / A_max, '-o')
xlabel('t')
legend('F', 'A')
grid on
grid minor

%% Fuel Mass
figure
hold on
plot(t, mf*0.001)
title('Fuel Mass (Tonnes)')
grid on
grid minor

%% Trajectory
figure 
hold on
plot(x/1000, y/1000)
title('Trajectory')
xlabel('x')
ylabel('y')
grid on
grid minor
axis equal

%% Flight Path Angle
figure 
hold on
plot(t, rad2deg(FPA))
xlabel('t')
ylabel('FPA')
grid on
grid minor
