function [ u ] = LQR_Controller( K, x, xe, ue, te, t )

% Find state to linearize around
[~, I] = min( abs(t - te) ); 

% Find Optimal Control
% u = u_eq - K * (x - x_eq)
u = ue(I) - K(I, :) * ( x - xe(I, :)' );

% Saturate Controls
if u > 0.25
    u = 0.25;
elseif u < -0.25
    u = -0.25;
end

end

