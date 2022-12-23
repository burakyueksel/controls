%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the ordered acceleration intervals for phases A to C.               %
%                                                                              %
% Inputs                                                                       %
%   v0     : initial velocity     : [1,1]                                      %
%   a0     : initial acceleration : [1,1]                                      %
%   amax   : maximum acceleration : [1,1]                                      %
%   jmax   : maximum jerk         : [1,1]                                      %
%   smax   : maximum snap         : [1,1]                                      %
%                                                                              %
% Output                                                                       %
%   int_ac : ordered acceleration intervals for phases A to C : [3,n]          %
%            (with n between 3 and 8).                                         %
%            int_ac(1,1)   : number of intervals                               %
%            int_ac(3,:)   : ordered acceleration intervals                    %
%            int_ac(2,:)   : corresponding velocity intervals                  %
%            int_ac(1,2:n) : corresponding values of case_ABC                  %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function int_ac=intervals_ac(v0,a0,amax,jmax,smax)
   aj=jmax^2/smax;
   A=[amax 0 aj -aj a0 a0+aj a0-aj];
   int_ac=[-amax];
   for k=1:7
      if((A(k)*a0<=0 || abs(A(k))>=abs(a0)) && abs(A(k))<=amax)
         l=1;
         n=size(int_ac,2);
         while(l<=n && A(k)>int_ac(l))
            l=l+1;
         end
         if(l>n || abs(A(k)-int_ac(l))>1e-4)
            int_ac=[int_ac(1:l-1) A(k) int_ac(l:n)];
         end
      end
   end
   int_ac=[zeros(2,size(int_ac,2));int_ac];
   n=size(int_ac,2)-1;
   int_ac(1,1)=n;
   for k=1:n
      a1=int_ac(3,k);
      int_ac(2,k)=v_c(a1,0,v0,a0,jmax,smax);
      a2=int_ac(3,k+1);
      int_ac(1,k+1)=case_abc((a1+a2)/2,a0,jmax,smax);
   end
   int_ac(2,n+1)=v_c(int_ac(3,n+1),0,v0,a0,jmax,smax);
end
