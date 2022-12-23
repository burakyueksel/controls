%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Returns discretized values of the spline and its first, second and third     %
% derivative for the inteval [0,tF] with                                       %
% tF=2*tA1+tA2+tB+2*tC1+tC2+tD+2*tE1+tE2+tG+2*tH1+tH2                          %
%                                                                              %
% Inputs                                                                       %
%    x0        : initial position                           : [1,1]            %
%    v0        : initial velocity                           : [1,1]            %
%    a0        : initial acceleration                       : [1,1]            %
%    xF        : final position                             : [1,1]            %
%    vF        : final velocity                             : [1,1]            %
%    aF        : final acceleration                         : [1,1]            %
%    smax      : maximum snap                               : [1,1]            %
%    durations : duration of the different phases           : [1,11]           %
%    signs     : sign of the snap during phases A,C,E and H : [1,4]            %
%    N         : desired number of points in the solution   : [1,1]            %
%                                                                              %
%    durations=[tA1 tA2 tB tC1 tC2 tD tE1 tE2 tG tH1 tH2]                      %
%    signs=[sA sC sE sH]                                                       %
%                                                                              %
% Outputs                                                                      %
%    T  : values of the time         : [1,N]                                   %
%    X  : values of the position     : [1,N]                                   %
%    V  : values of the velocity     : [1,N]                                   %
%    A  : values of the acceleration : [1,N]                                   %
%    Je : values of the jerk         : [1,N]                                   %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [T,X,V,A,Je]=spline_vector(x0,v0,a0,xF,vF,aF,smax,durations,signs,N)

   tF=sum(durations,2)+durations(1)+durations(4)+durations(7)+durations(10);
   tCD=sum(durations(1:6),2)+durations(1)+durations(4);

   T=[0:tF/(floor(N)-1):tF];
   X=zeros(1,N);
   V=zeros(1,N);
   A=zeros(1,N);
   Je=zeros(1,N);
   
   for k=1:N
      if(T(k)<tCD)
         [x,v,a,je]=spline_at_from_q0(T(k),x0,v0,a0,smax,durations,signs);
      else
         [x,v,a,je]=spline_at_from_qF(T(k),xF,vF,aF,smax,durations,signs);
      end
      X(k)=x;
      V(k)=v;
      A(k)=a;
      Je(k)=je;
   end

return
