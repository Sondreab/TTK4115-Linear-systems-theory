load('../Common files/wave.mat');
[Sxx, f] = pwelch(psi_w(2,:).*(pi/180), 4096, [], [], 10); %[Ws]
Sxx = Sxx*(1/(2*pi)); %convert to [W s/rad]
f = f*2*pi; %comes as [Hz] = [1/s] -> convert to [rad/s]

[sigma_sq,n] = max(Sxx); %finc max

sigma = sqrt(sigma_sq)

omega_0 = f(n) %resonance frequenzy

%Analytical PSD
Pxx = @(lambda, omega) ((2*lambda*omega*omega_0*sigma).^2) ...
    ./ ((omega_0^2 - omega.^2).^2 + (2*lambda*omega*omega_0).^2);

lambda = lsqcurvefit(Pxx, 0.1, f, Sxx) %Damping factor

%% Define figure size
width = 10; % cm
height = 10; % cm
fontsize = 10; % points
x = 20; y = 20; % Where on the screen the plot will appear, not important.

set(0,'DefaultTextInterpreter', 'latex') % Interpret (most) text as LaTeX.

%% Set up the figure
fig1 = figure(1);
fig1.Units = 'centimeters';
fig1.Position = [x y width height];

%% Plot the data
plot(f, Sxx); hold on;
plot(f, Pxx(lambda, f)); hold off;
xlim([0 2]);


%% Set up the properties of the axes
ax = gca;
ax.FontUnits = 'points';
ax.FontSize = fontsize;
ax.TickLabelInterpreter = 'latex'; 
xlabel('$\omega$ [rad/s]')
ylabel('Sxx [Ws/rad]')
legend('Empirical', 'Analytical, \lambda = 0.0865')
title('PSD')

ax.TitleFontSizeMultiplier = 1.1;

%include the following line to export the plot
%hgexport(fig1,'p5p2.eps')