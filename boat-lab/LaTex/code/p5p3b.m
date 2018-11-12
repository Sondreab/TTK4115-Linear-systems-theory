run('../Common files/p5p3_init.m');

sim('p5p3b_model');

t = BODYheading.Time(1:1000);
psi_r(1:500) = 30;
delta = RudderInput.Data(1:1000);
psi = BODYheading.Data(1:1000);

%% Define figure size
width = 10; % cm
height = 10; % cm
fontsize = 10; % points
x = 20; y = 20; 

set(0,'DefaultTextInterpreter', 'latex') 

%% Set up the figure
fig1 = figure(1);
fig1.Units = 'centimeters';
fig1.Position = [x y width height];

plot(psi_r,'red--');hold on
p = plot(t,psi,t,delta); hold off

p(1).LineWidth = 2;
p(2).LineWidth = 2;
ylim([-20 45])
xlim([0 300])

ax = gca; %get the axes handle of the current axes
ax.FontUnits = 'points';
ax.FontSize = fontsize;
ax.TickLabelInterpreter = 'latex'; %Interpret Tick labels as latex

xlabel('Time [s]')
ylabel('$\psi$, $\psi_r$, $\delta$ [deg]')
legend('\psi_r','\psi', '\delta')

title('Autopilot, only measurement noise')

%Set title to be 1.1 times larger than other fonts
ax.TitleFontSizeMultiplier = 1.1;