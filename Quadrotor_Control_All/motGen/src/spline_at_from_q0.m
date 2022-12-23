%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Returns the value of the spline and its first, second and third derivative   %
% at a given time parameter. If this parameter is negative the function        %
% returns the initial values and if the parameter is greater than the range of %
% the spline it returns the calculated final values.                           %
% In this function the algorithm starts from q0=[x0,v0,a0]                     %
%                                                                              %
% Inputs                                                                       %
%    t         : time parameter                             : [1,1]            %
%    x0        : initial position                           : [1,1]            %
%    v0        : initial velocity                           : [1,1]            %
%    a0        : initial acceleration                       : [1,1]            %
%    smax      : maximum snap                               : [1,1]            %
%    durations : duration of the different phases           : [1,11]           % 
%    signs     : sign of the snap during phases A,C,E and H : [1,4]            %
%                                                                              %
%    durations=[tA1 tA2 tB tC1 tC2 tD tE1 tE2 tG tH1 tH2]                      %
%    signs=[sA sC sE sH]                                                       %
%                                                                              %
% Outputs                                                                      %
%    x  : value of the position at t     : [1,1]                               %
%    v  : value of the velocity at t     : [1,1]                               %
%    a  : value of the acceleration at t : [1,1]                               %
%    je : value of the jerk at t         : [1,1]                               %
%    s  : value of the snap at t         : [1,1]                               %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,v,a,je,s]=spline_at_from_q0(t,x0,v0,a0,smax,durations,signs)

   t_cur=0;
   x_cur=x0;
   v_cur=v0;
   a_cur=a0;
   j_cur=0;   
   x=0;
   v = 0;
   a = 0;
   je=0;
   s=0;
   
   if(t<0)
      x=x_cur;
      v=v_cur;
      a=a_cur;
      je=j_cur;
      s=smax*signs(1);
      return;
   end
   
   stop=false;
   k=0;
   
   %T=[tA1 tA2 tA1 tB tC1 tC2 tC1 tD tE1 tE2 tE1 tG tH1 tH2 tH1]
   T=[durations(1) durations(2) durations(1) durations(3) ...
      durations(4) durations(5) durations(4) durations(6) ...
      durations(7) durations(8) durations(7) durations(9) ...
      durations(10) durations(11) durations(10)];

   %S=smax*[sA 0 -sA 0 sC 0 -sC 0 sE 0 -sE 0 sH 0 -sH];
   S=smax*[signs(1) 0 -signs(1) 0 signs(2) 0 -signs(2) 0 ...
           signs(3) 0 -signs(3) 0 signs(4) 0 -signs(4)];
           
   while(~stop && k<15)
      k=k+1;
      s=S(k);
      if(t_cur<=t && t<=t_cur+T(k))
         t_rel=t-t_cur;
         je=S(k)*t_rel+j_cur;
         a=(S(k)/2)*t_rel^2+j_cur*t_rel+a_cur;
         v=(S(k)/6)*t_rel^3+(j_cur/2)*t_rel^2+a_cur*t_rel+v_cur;
         x=(S(k)/24)*t_rel^4+(j_cur/6)*t_rel^3+(a_cur/2)*t_rel^2+v_cur*t_rel ...
          +x_cur;
         stop=true;
      end
      if(~stop && T(k)>0)
         t_cur=t_cur+T(k);
         x_cur=(S(k)/24)*T(k)^4+(j_cur/6)*T(k)^3+(a_cur/2)*T(k)^2+v_cur*T(k) ...
              +x_cur;
         v_cur=(S(k)/6)*T(k)^3+(j_cur/2)*T(k)^2+a_cur*T(k)+v_cur;
         a_cur=(S(k)/2)*T(k)^2+j_cur*T(k)+a_cur;
         j_cur=S(k)*T(k)+j_cur;
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
