%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% How to: (exemple of usage).                                                  %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('src');

% Limits
epsi=1e-4; %tolerance
xmax=10;
vmax=5;
amax=10;
jmax=20;
smax=1e2;
% How many splines? E.g. for 3DoF robot, it is 3.
NbDof=1;
% Positions Velocities and Acceleration
X0=[-10 -5 0 8 10];
XF=[-10 -5 0 8 10];
V0 = [-2 -3 0 2 0];
VF = [-2 -3 0 2 0];
A0 = [-2 -3 0 2 0];
AF = [-2 -3 0 2 0];

[tF,Durations,Signs]=durations_and_signs(X0,V0,A0,XF,VF,AF,vmax,amax,jmax,   ...
                                                                     smax,epsi);
colors=['r','g','b','m','c'];
NbPoints=1e3;

[T,X,V,A,Je]=disp_spline(X0,V0,A0,XF,VF,AF,tF,Durations,Signs,xmax,vmax,amax,jmax,smax,   ...
                                                               colors,NbPoints);
