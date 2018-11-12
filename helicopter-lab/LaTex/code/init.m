%%%%%%%%%%% Calibration of the encoder and the hardware
%%%%%%%%%%% for the specific helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]

v_s_star = 6.95; %Equilibrium voltage for elevation
k_f = g*(2*m_p*l_h-m_c*l_c)/(v_s_star*l_h); % Motorforce constant

k_1 = k_f/(2*m_p*l_p);
k_2 = (k_f*l_h)/(m_c*(l_c^2) + 2*m_p*(l_h^2));
k_3 = g*(m_c*l_c-2*m_p*l_h)/(m_c*(l_c^2)+2*m_p*((l_h^2)+(l_p^2)));