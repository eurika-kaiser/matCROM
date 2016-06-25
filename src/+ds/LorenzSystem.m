function dx = LorenzSystem(t, x)

% Constants for the chaotic Lorenz attractor
sigma = 10;
rho = 28;
beta = 8/3;

% ODE
dx = [ sigma*(x(2)-x(1));
       x(1)*(rho-x(3))-x(2);
       x(1)*x(2)-beta*x(3)];