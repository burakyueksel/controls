%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the durations of phases A1, A2, A3, C1, C2, C3 and signs of the     %
% snap during phases A1 and C1.                                                %
%                                                                              %
% Inputs                                                                       %
%    aB   : acceleration during phase B      : [1,1]                           %
%    a0   : initial acceleration             : [1,1]                           %
%    jmax : maximum jerk                     : [1,1]                           %
%    smax : maximum snap                     : [1,1]                           %
%                                                                              %
% Outputs                                                                      %
%    tA1  : duration of phases A1 and A3     : [1,1]                           %
%    tA2  : duration of phase A2             : [1,1]                           %
%    tC1  : duration of phases C1 and C3     : [1,1]                           %
%    tC2  : duration of phase C2             : [1,1]                           %
%    sA   : sign of the snap during phase A1 : [1,1]                           %
%    sC   : sign of the snap during phase C1 : [1,1]                           %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tA1,tA2,tC1,tC2,sA,sC]=durations_and_signs_ac(aB,a0,jmax,smax)
   sA=sign(aB-a0);
   sC=-sign(aB);
   if(abs(aB-a0)>jmax^2/smax)
      tA1=jmax/smax;
      tA2=abs(aB-a0)/jmax-jmax/smax;
   else
      tA1=sqrt(abs(a0-aB)/smax);
      tA2=0;
   end
   if(abs(aB)>jmax^2/smax)
      tC1=jmax/smax;
      tC2=abs(aB)/jmax-jmax/smax;
   else
      tC1=sqrt(abs(aB)/smax);
      tC2=0;
   end
end
