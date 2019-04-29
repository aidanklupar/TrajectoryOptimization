function [ u, tf ] = getInputs( decVars )

N = length(decVars)-1;

u = [decVars(1:N/2); decVars(N/2+1:end-1)];
tf = decVars(end);

end

