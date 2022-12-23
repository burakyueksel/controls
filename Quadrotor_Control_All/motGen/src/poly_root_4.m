%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the real roots of a polynom of the fourth order using               %
% Ferrari's method.                                                            %
%                                                                              %
% Inputs                                                                       %
%    a : coefficient of the fourth order : [1,1]                               %
%    b : coefficient of the third order  : [1,1]                               %
%    c : coefficient of the second order : [1,1]                               %
%    d : coefficient of the first order  : [1,1]                               %
%    e : constant term                   : [1,1]                               %
%                                                                              %
% Output                                                                       %
%    sol : real solutions of a*X^4+b*X^3+c*X^2+d*X+e=0 : [1,N] with N in [0 4] %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sol=poly_root_4(a,b,c,d,e)
   if(abs(a)<1e-10)
      sol=poly_root_3(b,c,d,e);
      return
   end
   A=b/a;
   B=c/a;
   C=d/a;
   D=e/a;
   P=B-(3/8)*A^2;
   Q=C-A*B/2+(1/8)*A^3;
   R=D-A*C/4+(1/16)*B*A^2-(3/256)*A^4;
   sol=ferrari(P,Q,R);
   sol=sol-A/4;
end
