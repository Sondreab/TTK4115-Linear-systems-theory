
w_1 = 0.005;
w_2 = 0.05;

omega = w_1;
sim('p5p1c_model.mdl');
compass_w1 = BODYheading;

omega = w_2;
sim('p5p1c_model.mdl');
compass_w2 = BODYheading;

plot(compass_w1.Time,compass_w1.Data,compass_w2.Time,compass_w2.Data);

amplitude_1 = peak2peak(compass_w1.Data(500:4500));
amplitude_2 = peak2peak(compass_w2.Data(1000:4500));

abs_H_1 = amplitude_1/2;
abs_H_2 = amplitude_2/2;

T = sqrt((abs_H_1^2 * w_1^2 - abs_H_2^2 * w_2^2)/(abs_H_2^2 * w_2^4 - abs_H_1^2 * w_1^4))
K = sqrt(abs_H_1^2 * (w_1^4 * T^2 + w_1^2))