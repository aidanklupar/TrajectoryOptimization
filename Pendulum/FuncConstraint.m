function [ c, c_eq ] = FuncConstraint( decVars, x0, xf, N, numInputs  )

% Get Inputs
[ dt, u, tf ] = getInputs( decVars, N, numInputs );

% Integrate EOM's
x0(3) = tf;
x_vec = shoot(u, dt, x0); 

% Compare Final Positions
xf_sim = x_vec(end, :)';
XF = xf_sim([1,2]) - xf([1,2]);

% Set equality and inequality constraints
c = -1;
c_eq = [XF];

end

