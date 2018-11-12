%%%%%% Integral effect
A_aug = [A, zeros(3,2); C, zeros(2,2)];
B_aug = [B; zeros(2,2)];

Q_aug = diag([60 10 200 10 30]);

K_aug = lqr(A_aug, B_aug, Q_aug, R);