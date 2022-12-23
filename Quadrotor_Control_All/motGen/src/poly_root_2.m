%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the real roots of a polynom of the second order.                    %
%                                                                              %
% Inputs                                                                       %
%    a : coefficient of the second order : [1,1]                               %
%    b : coefficient of the first order  : [1,1]                               %
%    c : constant term                   : [1,1]                               %
%                                                                              %
% Output                                                                       %
%    sol : real solutions of a*X^2+b*X+c=0 : [1,N] with N in [0 2]             %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sol=poly_root_2(a,b,c)
   if(abs(a)<1e-10)
      if(abs(b)<1e-10)
         sol=[-c];
         return
      end
      sol=[-c/b];
      return
   end
   d=b^2-4*a*c;
   if(d>0)
      sol=[(-b-sqrt(d))/(2*a) (-b+sqrt(d))/(2*a)];
   elseif(d==0)
      sol=[-b/(2*a)];
   else
      sol=[];
   end
end
