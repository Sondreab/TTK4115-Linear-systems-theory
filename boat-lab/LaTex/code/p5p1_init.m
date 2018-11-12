%Variable initialization
load('wave.mat');
w_1 = 0.005;
w_2 = 0.050;

%Found during our first simulation
abs_H_1 = 29.36;
abs_H_2 = 0.831;

T = sqrt((abs_H_1^2 * w_1^2 - abs_H_2^2 * w_2^2) ...
        /(abs_H_2^2 * w_2^4 - abs_H_1^2 * w_1^4));
K = sqrt(abs_H_1^2 * (w_1^4 * T^2 + w_1^2));
