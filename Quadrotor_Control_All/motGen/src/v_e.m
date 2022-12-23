%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the velocity at the begining of phase E.                            %
%                                                                              %
% Inputs                                                                       %
%   aG   : acceleration during phase G         : [1,1]                         %
%   tG   : duration of phase G                 : [1,1]                         %
%   vF   : final velocity                      : [1,1]                         %
%   aF   : final acceleration                  : [1,1]                         %
%   jmax : maximum jerk                        : [1,1]                         %
%   smax : maximum snap                        : [1,1]                         %
%                                                                              %
% Output                                                                       %
%   vC   : velocity at the begining of phase E : [1,1]                         %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function vE=v_e(aG,tG,vF,aF,jmax,smax)
   [tE1,tE2,tH1,tH2,sE,sH]=durations_and_signs_eh(aG,aF,jmax,smax);
   vE=sE*smax*tE1^3+(3*sE*smax*tE1^2*tE2)/2+(sE*smax*tE1*tE2^2)/2            ...
     +2*sH*smax*tE1*tH1^2+2*sH*smax*tE1*tH1*tH2-2*aF*tE1+sH*smax*tE2*tH1^2   ...
     +sH*smax*tE2*tH1*tH2-aF*tE2+sH*smax*tH1^3+(3*sH*smax*tH1^2*tH2)/2       ...
     +sH*smax*tG*tH1^2+(sH*smax*tH1*tH2^2)/2+sH*smax*tG*tH1*tH2-2*aF*tH1     ...
     -aF*tH2+vF-aF*tG;
return
