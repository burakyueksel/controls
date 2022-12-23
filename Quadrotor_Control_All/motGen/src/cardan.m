%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Implementation of Cardano's method.                                          %
%                                                                              %
% Inputs                                                                       %
%    p : coefficient of the first order  : [1,1]                               %
%    q : constant term                   : [1,1]                               %
%                                                                              %
% Output                                                                       %
%    sol : real solutions of X^3+p*X+q=0 : [1,N] with N in [1 3]               %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sol=cardan(p,q)
   delta=-(4*p^3+27*q^2);
   if(delta<0)
      v=((-delta/27)^(1/2))/2;
      u=-q/2+v;
      if(u<0)
         u=-(abs(u))^(1/3);
      else
         u=u^(1/3);
      end
      v=-q/2-v;
      if(v<0)
         v=-(abs(v))^(1/3);
      else
         v=v^(1/3);
      end
      sol=[u+v];
   elseif(delta>0)
      sol=[];
      u=(1/3)*acos((-q/2)*sqrt(27/(-p^3)));
      v=2*sqrt(-p/3);
      for k=0:2
         sol=[sol v*cos(u+2*k*pi/3)];
      end
   else
      if(p==0 && q==0)
         sol=[0];
      else
         sol=[3*q/p -3*q/(2*p)];
      end
   end
   
end
