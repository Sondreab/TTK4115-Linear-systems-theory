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
     
Ob = rank(obsv(A_obs, C_obs));

%Want observer poles x4-10 faster than system
%Slowest ple in A_aug_cl: -0.4434 
%-> slowest pole in observer (-1.7)-(-4.5)


Pol = [-4 -5 -6 -7 -8 -9];
L = place(A_obs', C_obs', Pol')';





