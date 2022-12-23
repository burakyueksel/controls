%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Returns the value of the spline and its first, second and third derivative   %
% at a given time parameter. If this parameter is negative the function        %
% returns the initial values and if the parameter is greater than the range of %
% the spline it returns the calculated final values.                           %
% In this function the algorithm starts from qF=[xF,vF,aF]                     %
%                                                                              %
% Input                                                                        %
%    t         : time parameter                             : [1,1]            %
%    xF        : final position                             : [1,1]            %
%    vF        : final velocity                             : [1,1]            %
%    aF        : final acceleration                         : [1,1]            %
%    smax      : maximum snap                               : [1,1]            %
%    durations : duration of the different phases           : [1,11]           % 
%    signs     : sign of the snap during phases A,C,E and H : [1,4]            %
%                                                                              %
%    durations=[tA1 tA2 tB tC1 tC2 tD tE1 tE2 tG tH1 tH2]                      %
%    signs=[sA sC sE sH]                                                       %
%                                                                              %
% Output                                                                       %
%    x  : value of the position at t     : [1,1]                               %
%    v  : value of the velocity at t     : [1,1]                               %
%    a  : value of the acceleration at t : [1,1]                               %
%    je : value of the jerk at t         : [1,1]                               %
%    s  : value of the snap at t         : [1,1]                               %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,v,a,je,s]=spline_at_from_qF(t,xF,vF,aF,smax,durations,signs)

    x=0;
    v=0;
    a=0;
    je=0;
    s=0;

   %T=[tH1 tH2 tH1 tG tE1 tE2 tE1 tD tC1 tC2 tC1 tB tA1 tA2 tA1]
   T=[durations(10) durations(11) durations(10) durations(9) ...
      durations(7) durations(8) durations(7) durations(6) ...
      durations(4) durations(5) durations(4) durations(3) ...
      durations(1) durations(2) durations(1)];
      
   tF=sum(T,2);

   t_cur=tF;
   x_cur=xF;
   v_cur=vF;
   a_cur=aF;
   j_cur=0;
      
   stop=false;
   k=0;
   
   if(t>tF)
      x=x_cur;
      v=v_cur;
      a=a_cur;
      je=j_cur;
      s=-smax*signs(4);
      return;
   end
      
   %S=smax*[-sH 0 sH 0 -sE 0 sE 0 -sC 0 sC 0 -sA 0 sA];
   S=smax*[-signs(4) 0 signs(4) 0 -signs(3) 0 signs(3) 0 ...
           -signs(2) 0 signs(2) 0 -signs(1) 0 signs(1)];
           
   while(~stop && k<15)
      k=k+1;
      s=S(k);
      if(t_cur-T(k)<=t && t<=t_cur)
         t_rel=t-t_cur+T(k);
         je=S(k)*t_rel+(j_cur-S(k)*T(k));
         a=(S(k)/2)*t_rel^2+(j_cur-S(k)*T(k))*t_rel+(a_cur+(S(k)/2)*T(k)^2   ...
          -j_cur*T(k));
         v=(S(k)/6)*t_rel^3+((j_cur-S(k)*T(k))/2)*t_rel^2                    ...
          +(a_cur+(S(k)/2)*T(k)^2-j_cur*T(k))*t_rel+(v_cur-(S(k)/6)*T(k)^3   ...
          +(j_cur/2)*T(k)^2-a_cur*T(k));
         x=(S(k)/24)*t_rel^4+((j_cur-S(k)*T(k))/6)*t_rel^3+((a_cur           ...
          +(S(k)/2)*T(k)^2-j_cur*T(k))/2)*t_rel^2+(v_cur-(S(k)/6)*T(k)^3     ...
          +(j_cur/2)*T(k)^2-a_cur*T(k))*t_rel                                ...
          +(x_cur+(S(k)/24)*T(k)^4-(j_cur/6)*T(k)^3+(a_cur/2)*T(k)^2         ...
          -v_cur*T(k));
         stop=true;
      end
      if(~stop && T(k)>0)
         t_cur=t_cur-T(k);
         x_cur=x_cur+(S(k)/24)*T(k)^4-(j_cur/6)*T(k)^3+(a_cur/2)*T(k)^2      ...
              -v_cur*T(k);
         v_cur=v_cur-(S(k)/6)*T(k)^3+(j_cur/2)*T(k)^2-a_cur*T(k);
         a_cur=a_cur+(S(k)/2)*T(k)^2-j_cur*T(k);
         j_cur=j_cur-S(k)*T(k);
      end
   end
   
   if(~stop)
      x=x_cur;
      v=v_cur;
      a=a_cur;
      je=j_cur;
      s=S(15);
   end
   
return
