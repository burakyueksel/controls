%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the durations of phases E1, E2, E3, H1, H2, H3 and signs of the     %
% snap during phases E1 and H1.                                                %
%                                                                              %
% Inputs                                                                       %
%    aG   : acceleration during phase G      : [1,1]                           %
%    a0   : initial acceleration             : [1,1]                           %
%    jmax : maximum jerk                     : [1,1]                           %
%    smax : maximum snap                     : [1,1]                           %
%                                                                              %
% Outputs                                                                      %
%    tE1  : duration of phases E1 and E3     : [1,1]                           %
%    tE2  : duration of phase E2             : [1,1]                           %
%    tH1  : duration of phases H1 and H3     : [1,1]                           %
%    tH2  : duration of phase H2             : [1,1]                           %
%    sH   : sign of the snap during phase E1 : [1,1]                           %
%    sH   : sign of the snap during phase H1 : [1,1]                           %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tE1,tE2,tH1,tH2,sE,sH]=durations_and_signs_eh(aG,aF,jmax,smax)
   sH=sign(aF-aG);
   sE=sign(aG);
   if(abs(aF-aG)>jmax^2/smax)
      tH1=jmax/smax;
      tH2=abs(aF-aG)/jmax-jmax/smax;
   else
      tH1=sqrt(abs(aF-aG)/smax);
      tH2=0;
   end
   if(abs(aG)>jmax^2/smax)
      tE1=jmax/smax;
      tE2=abs(aG)/jmax-jmax/smax;
   else
      tE1=sqrt(abs(aG)/smax);
      tE2=0;
   end
end
