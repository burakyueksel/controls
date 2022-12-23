close all
% clear all
clc
m     = 0.5;                               % mass in [kg]
J     = diag([0.557, 0.557, 1.05]*10e-2);  % inertia in [kg/m^2]
g     = 9.81;                              % gravitatonal constant [m/s^2]
initpos     = zeros(3,1);                  % initial position [m]                       
initlinvel  = zeros(3,1);                  % initial velocity [m/s]
initrotvel  = zeros(3,1);                  % initial body rot vel [rad/s]
initRotMat  = eye(3);                      % initial rotation matrix [#]
sim_step    = 0.01;                        % simulation step time [s]
max_tilt    = 45/180*pi;                   % maximum tilt angle [rad]
max_pos_err_norm = 10;                     % maximum position error norm [m]

kp=15;                                     % P gain of translational ctrl
kd=1.4*sqrt(4*kp);                         % D gain of translational ctrl
kd_z=kd;                                   % D gain of altitude ctrl
ki=1;                                      % I gain of altitude ctrl
KDR = 20;                                  % D gain of roll ctrl
KPR = 100;                                 % P gain of roll ctrl 
KDP = 20;   %50                            % D gain of pitch ctrl
KPP = 100;  %150                           % P gain of pitch ctrl
KDY = 10;                                  % D gain of yaw ctrl
%% STRUCTURE of TRAJECTORY GENERATION
Ap = [0 1 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0]; % Linear filter, A matrix for individual position traj.
Bp = [0 0 0 1]';                           % Linear filter, B matrix for individual position traj.
Apsi = [0 1; 0 0];                         % Linear filter, A matrix for yaw traj.
Bpsi = [0 1]';                             % Linear filter, B matrix for yaw traj.
traj_px = 1*[-1 -2 -3 -4];                 % Poles of x trajectories
traj_py = 1*[-1 -2 -3 -4];                 % Poles of y trajectories
traj_pz = 1*[-1 -2 -3 -4];                 % Poles of z trajectories
traj_psi= 1*[-1 -2];                       % Poles of yaw
% K_trajx = real(place(Ap,Bp,traj_px));    % Pole placement
% K_trajy = real(place(Ap,Bp,traj_py));
% K_trajz = real(place(Ap,Bp,traj_pz));
% K_trajpsi=real(place(Apsi,Bpsi,traj_psi));
K_trajx = real(place_4th_by(Ap,Bp,traj_px));      % self implemented 4-th order pole placement
K_trajy = real(place_4th_by(Ap,Bp,traj_py));
K_trajz = real(place_4th_by(Ap,Bp,traj_pz));
K_trajpsi=real(place_2nd_by(Apsi,Bpsi,traj_psi)); % self implemented 2-nd order pole placement