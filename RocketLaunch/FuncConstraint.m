function [ c, c_eq ] = FuncConstraint( decVars, t, y0, yf  )

% Run Scenario
y_vec = shoot(decVars, t, y0);

% Get final conditions
yf_sim = y_vec(1:5, end);

% Set inequality and equatity constraints
c = -1;
c_eq = yf_sim([2,3,4]) - yf([2,3,4]);

end

