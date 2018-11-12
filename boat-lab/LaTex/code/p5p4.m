%%%%%%%%%% No disturbances
A_none = [0 1; 0 -1/T];
B_none = [0; K/T];
C_none = [1 0];
D_none = 0;
E_none = 0;
sys_none = ss(A_none, B_none, C_none, D_none);
Ob_none = rank(obsv(sys_none))

%%%%%%%%%% Only current disturbances
A_current = [0 1 0; 0 -1/T -K/T; 0 0 0];
B_current = [0; K/T; 0];
C_current = [1 0 0];
D_current = 0;
E_current = [0; 0; 1];
sys_current = ss(A_current, B_current, C_current, D_current);
Ob_current = rank(obsv(sys_current))

%%%%%%%%%% Only wave disturbances
A_waves =  [0 1 0 0; 
            -(omega_0)^2 -2*lambda*omega_0 0 0;
            0 0 0 1;
            0 0 0 -1/T];
B_waves = [0; 0; 0; K/T];
C_waves = [0 1 1 0];
D_waves = 0;
E_waves = [0; K_w; 0; 0];
sys_waves = ss(A_waves, B_waves,C_waves, D_waves);
Ob_waves = rank(obsv(sys_waves))

%%%%%%%%%% Both current and wave disturbances
A_all = [0 1 0 0 0;
     -(omega_0)^2 -2*lambda*omega_0 0 0 0;
     0 0 0 1 0;
     0 0 0 -(1/T) -(K/T);
     0 0 0 0 0];
B_all = [0; 0; 0; K/T; 0];
C_all = [0 1 1 0 0];
D_all = 0;
E_all = [0 0; K_w 0; 0 0; 0 0; 0 1];
sys_all = ss(A_all, B_all, C_all, D_all);
Ob_all = rank(obsv(sys_all))