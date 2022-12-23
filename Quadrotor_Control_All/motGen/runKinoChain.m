%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% How to: (exemple of usage).                                                  %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
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
XAll = [0 -5 0 8 10 5 0];
VAll = [0 -3 0 2 0 4 0]; % must be in size of XAll
AAll = [0 -8 4 2 0 -2 0]; % must be in size of XAll

nrOfIntervals = length(XAll)-1;
colors=['r','g','b','m','c'];
NbPoints=1e3;
T=zeros(nrOfIntervals,NbPoints);
X=zeros(nrOfIntervals,NbPoints);
V=zeros(nrOfIntervals,NbPoints);
A=zeros(nrOfIntervals,NbPoints);
Je=zeros(nrOfIntervals,NbPoints);
%
TRes = zeros(1,nrOfIntervals*NbPoints);
XRes = zeros(1,nrOfIntervals*NbPoints);
CRes = zeros(1,nrOfIntervals*NbPoints);
ARes = zeros(1,nrOfIntervals*NbPoints);
JeRes = zeros(1,nrOfIntervals*NbPoints);
Tstart = 0;
TTrajChange = zeros(1,nrOfIntervals); % excluding start time, start is always zero
for i=1:nrOfIntervals
    X0 = XAll(i);
    XF = XAll(i+1);
    V0 = VAll(i);
    VF = VAll(i+1);
    A0 = AAll(i);
    AF = AAll(i+1);
    [tF,Durations,Signs]=durations_and_signs(X0,V0,A0,XF,VF,AF,vmax,amax,jmax,   ...
                                                                     smax,epsi);

    [T(i,:),X(i,:),V(i,:),A(i,:),Je(i,:)]=disp_spline_o(X0,V0,A0,XF,VF,AF,tF,Durations,Signs,xmax,vmax,amax,jmax,smax,   ...
                                                               colors,NbPoints);
    TRes((i-1)*NbPoints + 1: i*NbPoints)=Tstart+T(i,:);
    Tstart = Tstart+T(i,end); % end time of one spline is the start time of another
    TTrajChange(i)=Tstart;
    XRes((i-1)*NbPoints + 1: i*NbPoints)=X(i,:);
    VRes((i-1)*NbPoints + 1: i*NbPoints)=V(i,:);
    ARes((i-1)*NbPoints + 1: i*NbPoints)=A(i,:);
    JeRes((i-1)*NbPoints + 1: i*NbPoints)=Je(i,:);
end
%% plot chained trajectory
disp_Res(XRes,VRes,ARes,JeRes,TRes,TTrajChange,xmax,vmax,amax,jmax,smax,colors);
%%
Pos=timeseries(XRes,TRes);
Vel=timeseries(VRes,TRes);
Acc=timeseries(ARes,TRes);
save Pos.mat -v7.3 Pos ;
save Vel.mat -v7.3 Vel ;
save Acc.mat -v7.3 Acc ;