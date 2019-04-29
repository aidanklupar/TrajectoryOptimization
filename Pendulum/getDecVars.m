function [ decVars ] = getDecVars( dt, u, tf )

decVars = [dt(:); u(:); tf];
%decVars = [u(:)];

end