function [ J, dJ ] = FuncObjective( decVars )

[ u, tf, ~ ] = getInputs( decVars );

F = u(1, :);
A = u(2, :);

J = tf;

dJ = [zeros(size(F)), zeros(size(A)), 1, 0];

end