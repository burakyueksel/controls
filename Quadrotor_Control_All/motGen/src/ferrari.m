%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Implementation of Ferrari's method.                                          %
%                                                                              %
% Inputs                                                                       %
%    p : coefficient of the second order : [1,1]                               %
%    q : coefficient of the first order  : [1,1]                               %
%    r : constant term                   : [1,1]                               %
%                                                                              %
% Output                                                                       %
%    sol : real solutions of X^4+p*X^2+q*X+r=0 : [1,N] with N in [0 4]         %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sol=ferrari(p,q,r)
   if(q==0)
      delta=p^2-4*r;
      soltmp=poly_root_2(1,p,r);
      sol=[];
      for k=1:numel(soltmp)
         if(soltmp(k)>=0)
            sol=[sol -sqrt(soltmp(k)) sqrt(soltmp(k))];
         end
      end
   else
      y0=poly_root_3(1,-p/2,-r,p*r/2-q^2/8);
      y0=y0(1);
      if(2*y0-p<0)
         sol=poly_root_2(1,0,y0);
      else
         a0=sqrt(2*y0-p);
         if(2*y0-p==0)
            if(y0^2-r>0)
               b0=sqrt(y0^2-r);
            else
               b0=0;
            end
         else
            b0=-q/(2*a0);
         end
         sol=poly_root_2(1,a0,y0+b0);
         sol=[sol poly_root_2(1,-a0,y0-b0)];
      end
   end
end
