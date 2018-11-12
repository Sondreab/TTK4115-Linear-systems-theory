
load('../Common files/ScopeDataNoise.mat');
run('../Common files/p5p5_init.m');

%Discretization
sys = ss(A, B, C, D);      
Ts = 0.1;
sysd = c2d(sys, Ts);

van_loan = [A, E*Q*E';
            zeros(5), -(A')];
van_loan = expm(van_loan*Ts);
Q_w = van_loan(1:5,6:10)*(van_loan(1:5,1:5)');
v = ScopeData.signals.values;
R_v = var(v);
R_v_bar = R_v/Ts;

%Making data struct used in Kalman filter in simulink
data.A = sysd.A;
data.B = sysd.B;
data.C = sysd.C;
data.Q = Q_w;
data.R = R_v_bar;
data.P = P_0_apriori;
data.xhat0 = x_0_apriori;
data.I = eye(5);    

%Run sim
sim('p5p5d_model.mdl');

%load('..\Boat files\workspaceData\5.3')
t = BODYheading.Time(1:5000);

psi_r(1:5000) = 30;
psi_measured = BODYheading.Data(1:5000);
psi_filtered = psi_filtered.Data(1:5000);
delta = UnbiasedRudderInput.Data(1:5000);
bias = RudderBias.Data(1:5000);

%Plot the results...