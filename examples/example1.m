% Example: Lorenz system

clear all
close all

addpath('../src/');
path2figs = './output/'; mkdir(path2figs)

%% Simulate Lorenz system
[~, x] = ode45(@ds.LorenzSystem, [0,20],[3,3,3]');

dt     = 0.01;
t      = [0:dt:50];
[t, x] = ode45(@ds.LorenzSystem, t,x(end,:)');

figure,plot(t,x)

fhandle = figure('visible', 'on');
plot3(x(:,1),x(:,2),x(:,3),'-k')
view(45,20)
xlabel('x')
ylabel('y')
zlabel('z')
saveas(fhandle,[path2figs,'PhasePlot.png'])


%% Prepare Data & options 
Data2crom.dt = dt;
Data2crom.t  = t;
Data2crom.ts = x;

%  Cluster analysis parameters
params_user.nClusters      	     = 10;
params_user.nRepetitions         = 30;
params_user.optimalClustering    = 'sparsity';

%  Transition matrix parameters
params_user.ClusterOrdering      ='transitions';

% Additional settings
params_user.save    = 1;
params_user.verbose = 0;
params_user.plot    = 1;

%% CROM
CROMobj = CROM(Data2crom,params_user);
CROMobj.run
