K = 0.156
T = 72.44;

omega_c = 0.1;
T_f = -1/(omega_c*tan(130*pi/180));
Kpd = (sqrt(1 + (omega_c*T_f))*omega_c)/K;
T_d = T;

%comment back to get the bode plot
%s_num = [K];
%s_den = [T 1 0];

%H_s = tf(s_num, s_den);

%pd_num = [Kpd*T_d Kpd];
%pd_den = [T_f 1];

%H_pd = tf(pd_num, pd_den);

%H_0 = H_s*H_pd;

%figure(1);
%hold on
%bode(H_0)
