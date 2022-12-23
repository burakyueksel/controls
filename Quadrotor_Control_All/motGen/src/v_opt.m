%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the optimal velocity during phase D and the corresponding           %
% durations and snap signs for all phases.                                     %
%                                                                              %
% Inputs                                                                       %
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
%   v         : velocity during phase D : [1,1]                                %
%   tF        : total duration          : [1,1]                                %
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

function [v,tF,durations,signs,dX]=                                          ...
                v_opt(x0,v0,a0,xF,vF,aF,vmax,amax,jmax,smax,int_ac,int_eh,epsi);
   v1=0;
   dX1=d_x(v1,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
   s=sign(dX1);
   v2=s*vmax;
   dX2=d_x(v2,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
   v=v2-(v2-v1)*dX2/(dX2-dX1);
   [dX,tF,durations,signs]=                                                  ...
                     d_x(v,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
   nb_it=0;
   while(abs(dX)>epsi && nb_it<1e3)
      dX1=dX2;
      dX2=dX;
      v1=v2;
      v2=v;
      v=v2-(v2-v1)*dX2/(dX2-dX1);
      [dX,tF,durations,signs]=                                               ...
                     d_x(v,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
      nb_it=nb_it+1;
   end
   if(abs(v)>vmax || s*v<0)
      v=s*vmax;
      [dX,tF,durations,signs]=                                               ...
                     d_x(v,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
   end
   if(abs(dX)>epsi && s*dX<0)
      v1=0;
      v2=abs(v);
      v=v2/2;
      [dX,tF,durations,signs]=                                               ...
                   d_x(s*v,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
      while(abs(dX)>epsi && abs(v1-v2)>epsi)
         if(s*dX<0)
            v2=v;
         else
            v1=v;
         end
         v=(v1+v2)/2;
         [dX,tF,durations,signs]=                                            ...
                   d_x(s*v,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
      end
      if(s*dX<0)
         v=v1;
         [dX,tF,durations,signs]=                                            ...
                   d_x(s*v,x0,v0,a0,xF,vF,aF,amax,jmax,smax,int_ac,int_eh,epsi);
      end
      v=s*v;
   end

end
