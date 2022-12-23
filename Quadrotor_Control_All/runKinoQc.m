%% clear ws, add paths
clear all
addpath('simulate');
addpath('motGen');
addpath('motGen/src');
addpath('animate');
%% Initiate the trajectory generator with boundaries and the way points
% boundaries and WPs
epsi=1e-4; %tolerance
xmax=30;
vmax=5;
amax=10;
jmax=20;
smax=1e2;
% Positions Velocities and Acceleration
%        X-axis                                    Y-Axis                              Z-Axis
XAll = 3*[0 -8 -5 3 0 5 8 -4 0;                    0 5 8 -4 0 -8 -5 3 0;               0 -2 -8 4 0 2 8 4 0]; % Position WP
VAll = [0 -2 -1 -0.5 0 -2 -1 -0.5 0;               0 -2 -1 -0.5 0 -2 -1 -0.5 0;        0 -2 -1 -0.5 0 2 1 0.5 0]; % Velocity WP must be in size of XAll
AAll = [0 -1 -0.7 -0.3 0 -1 -0.7 -0.3 0;           0 -1 -0.7 -0.3 0 -1 -0.7 -0.3 0;    0 -1 -0.7 -0.3 0 -1 -0.7 -0.3 0]; % Acceleration WP must be in size of XAll
%% runKinoChain: Kinodynamic trajectory generator
runKinoChain2;
%% run simulation
initNH;
% sim('QuadNHTrajKino.slx')
sim('QuadSE3Kino.slx')
%% save plot as pdf
savePlotPdf('quadKino')
%% simple tracking result check
% plotTrackingResults
%% animate
animateQuad
plot3(XAll(1,:),-XAll(2,:),-XAll(3,:), 'k*'); % plot the WPs.