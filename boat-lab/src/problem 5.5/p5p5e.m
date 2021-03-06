
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
sim('p5p5e_model.mdl');


t = BODYheading.Time(1:5000);

psi_r(1:5000) = 30;
psi_measured = BODYheading.Data(1:5000);
psi_filtered = psi_filtered.Data(1:5000);
delta = UnbiasedRudderInput.Data(1:5000);
bias = RudderBias.Data(1:5000);
wave_influence = psi_w(2,1:5000);
wave_influence_est = psi_w_est.Data(1:5000);

%% Define figure size
width = 10; % cm
height = 10; % cm
fontsize = 10; % points
x = 20; y = 20; % Where on the screen the plot will appear, not important.

set(0,'DefaultTextInterpreter', 'latex') % Interpret (most) text as LaTeX.

%% Plot for system response
fig1 = figure(1);
fig1.Units = 'centimeters';
fig1.Position = [x y width height];

%% Plot the data
plot(psi_r,'red--');hold on

p = plot(t,psi_filtered,'c',t,psi_measured,'blue', ... 
    t,delta,'green',t,bias,'black'); hold off
%p = plot(t,wave_influence,'red',t,wave_influence_est,'blue'); hold off

p(1).LineWidth = 2;
p(2).LineWidth = 2;
p(3).LineWidth = 2;
p(4).LineWidth = 2;
ylim([-20 45])
xlim([0 300])

%% Set up the properties of the axes
% One figure can have multiple axes, for example if we use subplot
ax = gca; %get the axes handle of the current axes
% Set the fontsize and units correctly
ax.FontUnits = 'points';
ax.FontSize = fontsize;
ax.TickLabelInterpreter = 'latex'; %Interpret Tick labels as latex
% Label the axes, set up legend and title
xlabel('Time [s]')
ylabel('$\psi_r$, $\psi_{filtered}$, $\psi$, $\delta$, b [deg]')
legend('\psi_r','\psi_{filtered}','\psi', '\delta', 'b')
title('Kalman filter: with disturbances and noise')

%Set title to be 1.1 times larger than other fonts
ax.TitleFontSizeMultiplier = 1.1; 





%% Plot for wave influence
fig2 = figure(2);
fig2.Units = 'centimeters';
fig2.Position = [x y width height];

%% Plot the data
p = plot(t,wave_influence,'red',t,wave_influence_est,'blue');
p(1).LineWidth = 1;
p(2).LineWidth = 1;
ylim([-7 7])
xlim([0 300])

%% Set up the properties of the axes

ax = gca; %get the axes handle of the current axes
ax.FontUnits = 'points';
ax.FontSize = fontsize;
ax.TickLabelInterpreter = 'latex'; %Interpret Tick labels as latex
xlabel('Time [s]')
ylabel('Degrees')
legend('\psi_w','\psi_w,est')

title('Kalman filter: wave influence')

%Set title to be 1.1 times larger than other fonts
ax.TitleFontSizeMultiplier = 1.1;

hgexport(fig2,'p5p5e_wave_influence')

