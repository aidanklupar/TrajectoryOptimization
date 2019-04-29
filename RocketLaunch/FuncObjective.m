function [ J ] = FuncObjective( decVars, t, y0 )

% Max fuel remaining
y_vec = shoot(decVars, t, y0);
mf_sim = y_vec(5, end) - 24000;

J = -mf_sim;

end