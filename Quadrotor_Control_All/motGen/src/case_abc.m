%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Returns the value of case_ABC for a given value of aB.                       %
%                                                                              %
% Input                                                                        %
%    aB   : acceleration during phase B      : [1,1]                           %
%    a0   : initial acceleration             : [1,1]                           %
%    jmax : maximum jerk                     : [1,1]                           %
%    smax : maximum snap                     : [1,1]                           %
%                                                                              %
% Output                                                                       %
%    case_ABC : case code for given inputs   : [1,1]                           %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function case_ABC=case_abc(aB,a0,jmax,smax)
   sA=sign(aB-a0);
   sC=-sign(aB);
   cond_A=(abs(a0-aB)>jmax^2/smax);
   cond_C=(abs(aB)>jmax^2/smax);
   case_ABC=1000*(sA+1)+100*(sC+1)+10*cond_A+cond_C;
return
