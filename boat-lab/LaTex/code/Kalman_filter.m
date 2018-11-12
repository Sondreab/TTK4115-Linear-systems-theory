function [xi, psi_w, psi, r, bias] = fcn(u,y,data)
persistent xpri xhat P;

A = data.A;
B = data.B;
C = data.C;
Q = data.Q;
R = data.R;
I = data.I;
if isempty(xpri)
    xpri = data.xhat0;
    P = data.P;
end

K = P*C'/(C*P*C' + R);
xhat = xpri + K*(y - C*xpri);
P = (I - K*C)*P*(I - K*C)' + K*R*K';

xpri = A*xhat + B*u;
P = A*P*A' + Q;

xi = xhat(1);
psi_w = xhat(2);
psi = xhat(3);
r = xhat(4);
bias = xhat(5);