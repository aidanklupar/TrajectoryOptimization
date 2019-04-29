function [ u, tf, ts ] = getInputs( decVars )

N = length(decVars)-2;

u = [decVars(1:N/2); decVars(N/2+1:end-2)];
tf = decVars(end-1);
ts = decVars(end);

end

