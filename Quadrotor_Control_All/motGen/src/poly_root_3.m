%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the real roots of a polynom of the third order using                %
% Cardano's method.                                                            %
%                                                                              %
% Inputs                                                                       %
%    a : coefficient of the third order  : [1,1]                               %
%    b : coefficient of the second order : [1,1]                               %
%    c : coefficient of the first order  : [1,1]                               %
%    d : constant term                   : [1,1]                               %
%                                                                              %
% Output                                                                       %
%    sol : real solutions of a*X^3+b*X^2+c*X+d=0 : [1,N] with N in [0 3]       %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sol=poly_root_3(a,b,c,d)
   if(abs(a)<1e-10)
      sol=poly_root_2(b,c,d);
      return
   end
   A=b/a;
   B=c/a;
   C=d/a;
   P=B-A^2/3;
   Q=(2/27)*A^3-(1/3)*A*B+C;
   sol=cardan(P,Q);
   sol=sol-A/3;
end
