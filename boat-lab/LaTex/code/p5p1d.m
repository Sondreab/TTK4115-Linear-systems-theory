run('../Common files/p5p1_init.m');

Gain_T = T;
Gain_K = K;
sim('p5p1d_model.mdl');


set(0, 'DefaultTextInterpreter', 'latex')

plot(BODYheading.Time, BODYheading.Data, ...  
    ModelResponse.Time, ModelResponse.Data);
title('Step response: Model vs Ship');
xlabel('time [s]');
ylabel('$\psi$ [deg]');
legend('Ship','Model');