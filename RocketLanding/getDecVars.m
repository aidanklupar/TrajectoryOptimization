function [ decVars ] = getDecVars( u, tf, ts )

F = u(1, :);
A = u(2, :);
decVars = [F, A, tf, ts];

end

