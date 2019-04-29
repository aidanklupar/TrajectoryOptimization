clc; clearvars -except decVars ; close all;

% Optimization Variables
MaxIter   = 10;    % Maximum Number of Iterations
OptTol    = 1e-4;   % Optimality Tolerance   
ConTol    = 1e-2;   % Constraint Tolerance
StepTol   = 1e-8;   % Step Tolerance
Grad      = false;  % Objective Function Supplies Gradient?
CheckGrad = false;  % Numerically Check Supplied Gradient?

% Number of States and Inputs
numStates = 3;
numInputs = 1;

% Number of Points
N = 51;

% Initial and Final Conditions
tf0 = 15;
x0 = [0;  0; tf0];
xf = [pi; 0; tf0];

% Input Bounds
U_min = -0.25;
U_max =  0.25;

dt_avg = (1/(N-1));
dt_min = dt_avg;
dt_max = dt_avg;

% Get initial solution
dt = dt_avg * ones(N-1, 1);
u = rand(N, numInputs);

% Create Decision Variable vector
decVars = getDecVars( dt, u, tf0 );

% Set Upper and Lower Bounds
Ub = [dt_max * ones(size(dt)); U_max * ones(size(u)); inf];
Lb = [dt_min * ones(size(dt)); U_min * ones(size(u)); 0];

% Objective and Nonlinear Constraint Functions
func     = @(decVars) FuncObjective( decVars, N, numInputs );
confunc  = @(decVars) FuncConstraint( decVars, x0, xf, N, numInputs );

% Fixed Final Time
A_eq = [ones(1, numel(dt)), zeros(1, numel(u)), 0];
b_eq = 1;

A = [];
b = [];

% Numerical minimize objective function
options = optimoptions('fmincon', 'Display', 'iter', 'SpecifyObjectiveGradient', Grad, 'MaxFunctionEvaluations', 1e10, 'MaxIterations', MaxIter, 'OptimalityTolerance', OptTol, 'ConstraintTolerance', ConTol, 'CheckGradients', CheckGrad, 'StepTolerance', StepTol, 'Algorithm', 'sqp');
decVars = fmincon( func, decVars, A, b, A_eq, b_eq, Lb, Ub, confunc, options);

% Shoot from Inputs
[dt, u, tf] = getInputs(decVars, N, numInputs );
x0(3) = tf;
x_vec = shoot( u, dt, x0 );

Theta   = x_vec(:, 1);
dTheta  = x_vec(:, 2);
norm_tf = x_vec(1, 3);

t = [0; cumsum(dt)] * norm_tf;

% Plot Results
% Angular Position / Velocity
figure
subplot(1, 2, 1)
hold on
plot(t,  Theta/pi, '--o')
plot(t, dTheta/pi, '--o')
xlabel('Time (s)')
legend('\theta', 'd\theta', 'Location', 'best')
grid on
grid minor

subplot(1, 2, 2)
hold on
plot(t, u, '--o')
xlabel('Time (s)')
ylabel('Input Torque (N)')
grid on
grid minor

