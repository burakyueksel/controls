%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the difference between the positions at the end of phase C and at   %
% the beginning of phase E given a desired velocity during phase D and the     %
% corresponding durations and snap signs for all phases.                       %
%                                                                              %
% Inputs                                                                       %
%   vD     : desired velocity during phase D                                   %
%   x0     : initial position     : [1,1]                                      %
%   v0     : initial velocity     : [1,1]                                      %
%   a0     : initial acceleration : [1,1]                                      %
%   xF     : final position       : [1,1]                                      %
%   vF     : final velocity       : [1,1]                                      %
%   aF     : final acceleration   : [1,1]                                      %
%   vmax   : maximum velocity     : [1,1]                                      %
%   amax   : maximum acceleration : [1,1]                                      %
%   jmax   : maximum jerk         : [1,1]                                      %
%   smax   : maximum snap         : [1,1]                                      %
%   int_ac : ordered acceleration intervals for phases A to C : [3,n]          %
%            (with n between 3 and 8)                                          %
%   int_eh : ordered acceleration intervals for phases E to H : [3,m]          %
%            (with m between 3 and 8)                                          %
%   epsi   : tolerance on numerical error (stopping condition for numerical    %
%            optimization)                                                     %
%                                                                              %
% Outputs                                                                      %
%   dX        : difference between the positions at the end of phase C and at  %
%               the beginning of phase E given input velocity vD : [1,1]       %
%   tF        : total duration                                   : [1,1]       %
%   durations : duration of all phases                           : [1,11]      %
%   signs     : signs of the snap                                : [n,1]       %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [dX,tF,durations,signs]= ...
                     d_x(vD,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi)
   [aB,tB]=a_b(vD,v0,a0,amax,jmax,smax,int_ac,epsi);
   [tA1,tA2,tC1,tC2,sA,sC]=durations_and_signs_ac(aB,a0,jmax,smax);
   [aG,tG]=a_g(vD,vF,aF,amax,jmax,smax,int_eh,epsi);
   [tE1,tE2,tH1,tH2,sE,sH]=durations_and_signs_eh(aG,aF,jmax,smax);
   xC=x_c(aB,tB,x0,v0,a0,jmax,smax);
   xE=x_e(aG,tG,xF,vF,aF,jmax,smax);
   dX=(xE-xC);
   tD=0;
   if(abs(vD)>1e-6)
      tD=dX/vD;
   end
   if(tD<0 || abs(tD)==Inf || isnan(tD))
      tD=0;
   end
   tF=2*tA1+tA2+tB+2*tC1+tC2+tD+2*tE1+tE2+tG+2*tH1+tH2;
   durations=[tA1 tA2 tB tC1 tC2 tD tE1 tE2 tG tH1 tH2];
   signs=[sA sC sE sH];
end
