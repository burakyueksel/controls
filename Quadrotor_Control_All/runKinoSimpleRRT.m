clear all
%% read way points from the txt
data             = fileread('smoothedpath.txt');
dataflt          = str2num(data);
wayPoints        = flipud(dataflt);
boundaries       = wayPoints(end,:);
wayPoints(end,:) = [];
%% add paths
addpath('simulate');
addpath('motGen');
addpath('motGen/src');
addpath('animate');
addpath('utils');
%% Initiate the trajectory generator with boundaries and the way points
% boundaries and WPs
epsi=1e-4; %tolerance
xmax=max(abs(boundaries));
vmax=5;
amax=10;
jmax=20;
smax=1e2;
% Positions Velocities and Acceleration
%        X-axis                                             Y-Axis                                      Z-Axis
XAll = [wayPoints(:,1)';                                   wayPoints(:,2)';                       zeros(1,length(wayPoints))]; % Position WP
VAll = [zeros(1,length(wayPoints));                        zeros(1,length(wayPoints));            zeros(1,length(wayPoints))]; % Velocity WP must be in size of XAll
AAll = [zeros(1,length(wayPoints));                        zeros(1,length(wayPoints));            zeros(1,length(wayPoints))]; % Acceleration WP must be in size of XAll 
%% runKinoChain: Kinodynamic trajectory generator
runKinoChain2;
%%
initNH;
sim('QuadNHTrajKino.slx')
% sim('QuadSE3Kino.slx')
%% animate
animateQuad
plot3(XAll(1,:),-XAll(2,:),-XAll(3,:), 'k*'); % plot the WPs.