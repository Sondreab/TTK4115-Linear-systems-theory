%%%%%%%%%%% Multivarible system
A = [0 1 0; 0 0 0; 0 0 0];
B = [0 0; 0 k_1; k_2 0];
C = [1 0 0; 0 0 1];

Q = diag([50 10 200]);
R = diag([5 10]);

K = lqr(A, B, Q, R);
P = inv(C*inv(B*K-A)*B);