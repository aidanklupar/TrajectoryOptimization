clc; close all;

% Optimization Options
MaxIter   = 100;   % Maximum number of Iterations
OptTol    = 1e-6;  % Optimality Tolerance
ConTol    = 1e-1;  % Constraint Tolerance
StepTol   = 1e-6;  % Step Tolerance
Grad      = true; % Gradient Supplied by minimization function?
checkGrad = true; % Check gradient supplied with numerical methods?

% Number of Data Points
N = 51;

% Number of States and Inputs
numStates = 5;
numInputs = 2;

% Input Constraints
F_min =  0.7*2;
F_max =  2;

A_min = -pi/3;
A_max =  pi/3;

% Initial & Final Conditions
tf0 = 20;
ts0 = 0;
yf = [   0;  0;  0; 0; tf0];

% Create solution arrays
t = linspace(0, 1, N);
u = [2*ones(1, N); 0*ones(1, N)];

% Get decision variables
decVars = getDecVars( u, tf0, ts0 );

% Set Upper Bounds and Lower Bounds
Ub = [F_max * ones(1, N), A_max * ones(1, N), inf, inf];
Lb = [F_min * ones(1, N), A_min * ones(1, N), 0, 0];

% Find optimal control
func     = @(decVars) FuncObjective(decVars);
confunc  = @(decVars) FuncConstraint(decVars, t, yf);

options = optimoptions('fmincon', 'Display', 'iter', 'SpecifyObjectiveGradient', Grad, 'MaxFunctionEvaluations', 1e10, 'MaxIterations', MaxIter, 'OptimalityTolerance', OptTol, 'ConstraintTolerance', ConTol, 'CheckGradients', checkGrad, 'StepTolerance', StepTol);
decVars = fmincon( func, decVars, [], [], [], [], Lb, Ub, confunc, options);

% Run Optimal Control and Print Results
[u, tf, ts] = getInputs(decVars);
y_vec = shoot( decVars, t );

x   = y_vec(1, :);
y   = y_vec(2, :);
v_x = y_vec(3, :);
v_y = y_vec(4, :);
t = t * tf;

F = u(1, :);
A = u(2, :);

%% Position
figure
hold on
plot(t, x, '-o')
plot(t, y, '-o')
title('Positions')
xlabel('t')
legend('x', 'y')
grid on
grid minor

%% Velocity
figure
hold on
title('Velocities')
plot(t, v_x, '-o')
plot(t, v_y, '-o')
xlabel('t')
legend('v_x', 'v_y')
grid on
grid minor

%% Control Inputs
figure
hold on
title('Inputs')
plot(t, F / F_max, '-o')
plot(t, A / A_max, '-o')
xlabel('t')
legend('F', 'A')
grid on
grid minor

%% Trajectory
figure 
hold on
plot(x, y)
title('Trajectory')
xlabel('x')
ylabel('y')
grid on
grid minor
axis equal

