%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Returns the value of case_EHG for a given value of aG.                       %
%                                                                              %
% Inputs                                                                       %
%    aG   : acceleration during phase G      : [1,1]                           %
%    tG   : initial acceleration             : [1,1]                           %
%    jmax : maximum jerk                     : [1,1]                           %
%    smax : maximum snap                     : [1,1]                           %
%                                                                              %
% Output                                                                       %
%    case_EGH : case code for given inputs   : [1,1]                           %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function case_EGH=case_egh(aG,aF,jmax,smax)
   sH=sign(aF-aG);
   sE=sign(aG);
   cond_H=(abs(aG-aF)>jmax^2/smax);
   cond_E=(abs(aG)>jmax^2/smax);
   case_EGH=1000*(sH+1)+100*(sE+1)+10*cond_H+cond_E;
return
