K = 0.156;
T = 72.44;
omega_c = 0.1;
T_f = -1/(omega_c*tan(130*pi/180));
Kpd = (sqrt(1 + (omega_c*T_f))*omega_c)/K;
T_d = T;
%%%%%%% Variable initialization
load('wave.mat');
[Sxx, f] = pwelch(psi_w(2,:).*(pi/180), 4096, [], [], 10); % [Ws]
Sxx = Sxx*(1/(2*pi)); %convert to [W s/rad]
f = f*2*pi; %comes as [Hz] = [1/s] -> convert to [rad/s]
[sigma_sq,n] = max(Sxx); %finc max
sigma = sqrt(sigma_sq);
omega_0 = f(n); %resonance frequenzy
%Analytical PSD
Pxx = @(lambda, omega) ((2*lambda*omega*omega_0*sigma).^2) ... 
    ./ ((omega_0^2 - omega.^2).^2 + (2*lambda*omega*omega_0).^2);
lambda = lsqcurvefit(Pxx, 0.1, f, Sxx); %Damping factor

K_w = 2*lambda*omega_0*sigma;
%%%%%% Continous system
A = [0 1 0 0 0;
     -(omega_0)^2 -2*lambda*omega_0 0 0 0;
     0 0 0 1 0;
     0 0 0 -(1/T) -(K/T);
     0 0 0 0 0];
B = [0; 0; 0; K/T; 0];
C = [0 1 1 0 0];
D = 0;
E = [0 0; K_w 0; 0 0; 0 0; 0 1];
%%%%%%Given in assignment text
Q = [30 0;
       0 1e-6];   
P_0_apriori = [1 0 0 0 0;
             0 0.013 0 0 0;
             0 0 pi^2 0 0;
             0 0 0 1 0;
             0 0 0 0 2.5e-3];         
x_0_apriori = zeros(5,1);
%%%%% End of handed out values