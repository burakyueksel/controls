%% clear ws, add paths
clear all
addpath('simulate');
addpath('motGen');
addpath('motGen/src');
addpath('animate');
addpath('utils');
%% Initiate the trajectory generator with boundaries and the way points
% boundaries and WPs
epsi=1e-4; %tolerance
xmax=10;
vmax=5;
amax=3;
jmax=4;
smax=1e2;
% Positions Velocities and Acceleration
%        X-axis  
XAll = [-4 10 ]; % Position WP
VAll = [-2 0 ]; 
AAll = [1  -1 ];   
%% runKinoChain: Kinodynamic trajectory generator
runKinoChain2;
%% save plot as pdf
savePlotPdf('simpleKino')