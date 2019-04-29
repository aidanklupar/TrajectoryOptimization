function [ J ] = FuncObjective( decVars, N, numInputs )

[ dt, u, tf ] = getInputs( decVars, N, numInputs );

t = [0; cumsum(dt)] * tf;

J = trapz(t, abs(u));

end