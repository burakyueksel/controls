%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the velocity at the end of phase C.                                 %
%                                                                              %
% Inputs                                                                       %
%   aB   : acceleration during phase B    : [1,1]                              %
%   tB   : duration of phase B            : [1,1]                              %
%   v0   : initial velocity               : [1,1]                              %
%   a0   : initial acceleration           : [1,1]                              %
%   jmax : maximum jerk                   : [1,1]                              %
%   smax : maximum snap                   : [1,1]                              %
%                                                                              %
% Output                                                                       %
%   vC   : velocity at the end of phase C : [1,1]                              %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function vC=v_c(aB,tB,v0,a0,jmax,smax)
   [tA1,tA2,tC1,tC2,sA,sC]=durations_and_signs_ac(aB,a0,jmax,smax);
   vC=sA*smax*tA1^3+(3*sA*smax*tA1^2*tA2)/2+2*sA*smax*tA1^2*tC1              ...
     +sA*smax*tA1^2*tC2+sA*smax*tB*tA1^2+(sA*smax*tA1*tA2^2)/2               ...
     +2*sA*smax*tA1*tA2*tC1+sA*smax*tA1*tA2*tC2+sA*smax*tB*tA1*tA2+2*a0*tA1  ...
     +a0*tA2+sC*smax*tC1^3+(3*sC*smax*tC1^2*tC2)/2+(sC*smax*tC1*tC2^2)/2     ...
     +2*a0*tC1+a0*tC2+v0+a0*tB;
return
