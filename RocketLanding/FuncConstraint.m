function [ c, c_eq ] = nonlcon( decVars, t, yf  )

% Run Scenario
[ ~, tf, ts ] = getInputs( decVars );
y_vec = shoot(decVars, t);

% Get final conditions
yf_sim = y_vec(1:4, end);

%t = t*tf;
%n = find(t > tf-2);
VX = y_vec(3, end-4:end)';
%VX = 0;

% Final time must be positive and rocket can't go below horizon
c = [-tf, -y_vec(2, :), -ts];

% Final y, dx, dy must match the supplied final conditions
c_eq = [yf_sim([1,2,3,4]) - yf([1,2,3,4]); VX];

end

