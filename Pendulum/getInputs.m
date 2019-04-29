function [ dt, u, tf ] = getInputs( decVars, N, numInputs )

dt = decVars(1:N-1);
u = reshape(decVars(N:end-1), N, numInputs);
tf = decVars(end);


end

