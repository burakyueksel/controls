%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Synchronizes a component to a given duration.                                %
%                                                                              %
% Inputs                                                                       %
%   tF_des : desired total duration          : [1,1]                           %
%   tF_ini : initial total duration          : [1,1]                           %
%   v_opt  : optimal velocity during phase D : [1,1]                           %
%   x0     : initial position                : [1,1]                           %
%   v0     : initial velocity                : [1,1]                           %
%   a0     : initial acceleration            : [1,1]                           %
%   xF     : final position                  : [1,1]                           %
%   vF     : final velocity                  : [1,1]                           %
%   aF     : final acceleration              : [1,1]                           %
%   vmax   : maximum velocity                : [1,1]                           %
%   amax   : maximum acceleration            : [1,1]                           %
%   jmax   : maximum jerk                    : [1,1]                           %
%   smax   : maximum snap                    : [1,1]                           %
%   int_ac : ordered acceleration intervals for phases A to C : [3,n]          %
%            (with n between 3 and 8)                                          %
%   int_eh : ordered acceleration intervals for phases E to H : [3,m]          %
%            (with m between 3 and 8)                                          %
%   epsi   : tolerance on numerical error (stopping condition for numerical    %
%            optimization)                                                     %
%                                                                              %
% Outputs                                                                      %
%   vD        : velocity during phase D                    : [1,1]             %
%   tF        : total duration                             : [1,1]             %
%   durations : duration of the different phases           : [1,11]            %
%               durations=[tA1 tA2 tB tC1 tC2 tD tE1 tE2 tG tH1 tH2]           %
%   signs     : sign of the snap during phases A,C,E and H : [1,4]             %
%               signs=[sA sC sE sH]                                            %
%   dX        : difference between the positions at the end of phase C and at  %
%               the beginning of phase E                   : [1,1]             %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [vD,tF,durations,signs,dX]=synchronize(tF_des,tF_ini,v_opt,x0,v0,a0 ...
                                    ,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi)

   if(tF_ini<tF_des)
      s=sign(v_opt);
      minv=0;
      maxv=abs(v_opt);
      vD=maxv/2;
      [dX,tF,durations,signs]=                                               ...
                  d_x(s*vD,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
      while(abs(tF-tF_des)>epsi && abs(minv-maxv)>epsi/100)
         if(tF<tF_des)
            maxv=vD;
         else
            minv=vD;
         end
         vD=(minv+maxv)/2;
         [dX,tF,durations,signs]= ...
                  d_x(s*vD,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
      end
      vD=s*vD;
   else
      vD=v_opt;
      [dX,tF,durations,signs]= ...
                    d_x(vD,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
   end
   
end
