%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% How to: (example of usage).                                                  %
%                                                                              %
% Author: Burak Yüksel:-                                                       %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('src');
[NbDof,lenghtPoints] = size(XAll);
nrOfIntervals = lenghtPoints-1;
colors=['r','g','b','m','c'];
NbPoints=1e3;
%
TRes = zeros(NbDof,nrOfIntervals*NbPoints);
XRes = zeros(NbDof,nrOfIntervals*NbPoints);
VRes = zeros(NbDof,nrOfIntervals*NbPoints);
ARes = zeros(NbDof,nrOfIntervals*NbPoints);
JeRes = zeros(NbDof,nrOfIntervals*NbPoints);
TTrajChange = zeros(NbDof,nrOfIntervals); % excluding start time, start is always zero

Tstart = 0;
T=zeros(NbDof,nrOfIntervals,NbPoints);
X=zeros(NbDof,nrOfIntervals,NbPoints);
V=zeros(NbDof,nrOfIntervals,NbPoints);
A=zeros(NbDof,nrOfIntervals,NbPoints);
Je=zeros(NbDof,nrOfIntervals,NbPoints);
for interval=1:nrOfIntervals
    
    X0 = XAll(:,interval);
    XF = XAll(:,interval+1);
    V0 = VAll(:,interval);
    VF = VAll(:,interval+1);
    A0 = AAll(:,interval);
    AF = AAll(:,interval+1);
    [tF,Durations,Signs]=durations_and_signs(X0,V0,A0,XF,VF,AF,vmax,amax,jmax,   ...
        smax,epsi);
    [T(:,interval,:),X(:,interval,:),V(:,interval,:),A(:,interval,:),Je(:,interval,:)]=disp_spline_o_2(X0,V0,A0,XF,VF,AF,tF,Durations,Signs,xmax,vmax,amax,jmax,smax,   ...
        colors,NbPoints);
%     [a,b,c,d,e]=disp_spline_o_2(X0,V0,A0,XF,VF,AF,tF,Durations,Signs,xmax,vmax,amax,jmax,smax,   ...
%         colors,NbPoints);
    TRes(:,(interval-1)*NbPoints + 1: interval*NbPoints)=Tstart+T(:,interval,:);
    Tstart = Tstart+T(:,interval,end); % end time of one spline is the start time of another
    TTrajChange(:,interval)=Tstart;
    XRes(:,(interval-1)*NbPoints + 1: interval*NbPoints)=X(:,interval,:);
    VRes(:,(interval-1)*NbPoints + 1: interval*NbPoints)=V(:,interval,:);
    ARes(:,(interval-1)*NbPoints + 1: interval*NbPoints)=A(:,interval,:);
    JeRes(:,(interval-1)*NbPoints + 1: interval*NbPoints)=Je(:,interval,:);
end
%% plot chained trajectory
disp_Res2(XRes,VRes,ARes,JeRes,TRes,TTrajChange,xmax,vmax,amax,jmax,smax,colors);
%%
Pos=timeseries(XRes,TRes(1,:));
Vel=timeseries(VRes,TRes(1,:));
Acc=timeseries(ARes,TRes(1,:));
Jerk=timeseries(JeRes,TRes(1,:));
save Pos.mat -v7.3 Pos ;
save Vel.mat -v7.3 Vel ;
save Acc.mat -v7.3 Acc ;
save Jerk.mat -v7.3 Jerk ;