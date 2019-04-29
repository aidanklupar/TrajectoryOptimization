function [ K ] = getLQR( x_vec )

% For each time, linearize around state and find optimal K matrix from LQR

% Set LQR objective matrix
Q = diag([1, 1e-2]);
R = 100*eye(1);
[N, ~] = size(x_vec);

K = zeros(N, 2);
for i = 1:N
    % Linearize around state
    T = x_vec(i, 1);
    A = [0 1; -cos(T) 0];
    B = [0; 1];
    
    % get LQR control matrix K
    K(i, :) = lqr(A, B, Q, R);
end

