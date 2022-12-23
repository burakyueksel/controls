%% clear ws, add paths
clear all
addpath('simulate');
addpath('motGen');
addpath('motGen/src');
addpath('animate');
%% run simulation
initNH;
setPos = [1 1 1]';
setYaw = 0.5;
sim('QuadNHStepInput.slx')
% sim('QuadNHStepInput_dyn2.slx')
%% simple tracking result check
% plotTrackingResults
%% animate
animateQuad