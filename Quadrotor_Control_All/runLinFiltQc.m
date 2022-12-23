%% clear ws, add paths
clear all
addpath('simulate');
addpath('motGen');
addpath('motGen/src');
addpath('animate');
%% run simulation
initNH;
% sim('QuadNHTrajLinFilt.slx')
% sim('QuadNHTrajLinFilt_dyn2.slx')
sim('QuadSE3TrajLinFilt.slx')
% sim('QuadSE3AdaptiveTrajLinFilt.slx')
%% simple tracking result check
plotTrackingResults
%% animate
animateQuad