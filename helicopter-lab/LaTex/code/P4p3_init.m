%%%%%% Observer

A_obs = [0 1 0 0 0 0;
         0 0 0 0 0 0;
         0 0 0 1 0 0;
         0 0 0 0 0 0;
         0 0 0 0 0 1;
       k_3 0 0 0 0 0];
   
B_obs = [0 0;
         0 k_1;
         0 0;
       k_2 0;
         0 0;
         0 0];
     
C_obs = [1 0 0 0 0 0;
         0 0 1 0 0 0;
         0 0 0 0 1 0];
     
C_obs_not_p = [0 0 1 0 0 0;
               0 0 0 0 1 0];
           
C_obs_not_lambda = [1 0 0 0 0 0;
                    0 0 1 0 0 0];
     
Ob = rank(obsv(A_obs, C_obs));
Ob_not_p = rank(obsv(A_obs, C_obs_not_p));
Ob_not_lambda = rank(obsv(A_obs, C_obs_not_lambda));

%Want observer poles x4-10 faster than system
%Slowest pole in A_aug_cl: -0.4434 
%-> slowest pole in observer (-1.7)-(-4.5)
convert = pi/180;
theta = 20*[1 -1 2 -2 3 -3]*convert;
Pol = -2*[exp(1i*theta(1)) exp(1i*theta(2)) exp(1i*theta(3))
		  exp(1i*theta(4)) exp(1i*theta(5)) exp(1i*theta(6))];
L = place(A_obs', C_obs_not_p', Pol')';

A_LC = A_obs-L*C_obs_not_p;
poles_A_LC = eig(A_LC);





