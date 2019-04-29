function [ decVars ] = getDecVars( u, tf )

F = u(1, :);
A = u(2, :);
decVars = [F, A, tf];

end

